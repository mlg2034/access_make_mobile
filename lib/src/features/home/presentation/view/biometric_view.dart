import 'package:acces_make_mobile/src/features/home/bloc/check_biometric/home_bloc.dart';
import 'package:acces_make_mobile/src/features/home/presentation/view/face_camera_view.dart';
import 'package:acces_make_mobile/src/features/home/presentation/view/face_mesh_detector_view.dart';
import 'package:acces_make_mobile/src/ui_kit/ui_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricView extends StatefulWidget {
  const BiometricView({
    super.key,
  });

  @override
  State<BiometricView> createState() => _BiometricViewState();
}

class _BiometricViewState extends State<BiometricView> {
  @override
  void initState() {
    context.read<CheckBiometricBloc>().add(
          ChechBiometri(),
        );
    super.initState();
  }

  _biometricListener(
    BuildContext context,
    CheckBiometricState state,
  ) {
    switch (state) {
      case CheckBiometricError():
        return snackBarBuilder(
          context,
          SnackBarOptions(
            title: state.error,
            type: SnackBarType.error,
          ),
        );

      case CheckBiometricSuccess():
        return snackBarBuilder(
          context,
          SnackBarOptions(
            title: 'Success!',
            type: SnackBarType.success,
          ),
        );
      case NotIndentified():
        return snackBarBuilder(
          context,
          SnackBarOptions(
            title: 'Warning!',
            type: SnackBarType.warning,
          ),
        );
      default:
        break;
    }
  }

  VoidCallback _tryAgain(BuildContext context) => () {
        context.read<CheckBiometricBloc>().add(
              ChechBiometri(),
            );
      };

      VoidCallback _toRegistration(BuildContext context)=>(){

      };


  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckBiometricBloc, CheckBiometricState>(
      listener: _biometricListener,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const AspectRatio(
              aspectRatio: 1,
              child: FaceCameraView(),
            ),
          ),
          const Spacer(),
          BlocBuilder<CheckBiometricBloc, CheckBiometricState>(
            builder: (context, state) {
              if (state is CheckBiometricError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Произошла ошибка, попробуйте снова  ',
                      style: AppFonts.displayMedium.copyWith(
                        color: AppColors.blue.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppButton(
                      onPressed: _tryAgain(context),
                      child: Text(
                        'Попробовать снова',
                        style: AppFonts.displaySmall.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    )
                  ],
                );
              } else if (state is CheckBiometricSuccess) {
                return Text(
                  'Вы успешно прошли биометрию!',
                  style: AppFonts.displayMedium.copyWith(
                    color: AppColors.blue.withOpacity(0.8),
                  ),
                );
              } else if (state is NotIndentified) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Мы не нашли вас в нашей системе.\n Пройдите регистрацию и попробуйте снова',
                      style: AppFonts.displayMedium.copyWith(
                        color: AppColors.blue.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppButton(
                      onPressed: _toRegistration(context),
                      child: Text(
                        'На регистрацию',
                        style: AppFonts.displaySmall.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    )
                  ],
                );
              }
              return Text(
                'Пройдите биометрию для входа',
                style: AppFonts.displayMedium.copyWith(
                  color: AppColors.blue.withOpacity(0.8),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
