import 'package:acces_make_mobile/core/utils/phone_input_formatter.dart';
import 'package:acces_make_mobile/src/features/registration/bloc/registration/registation_bloc.dart';
import 'package:acces_make_mobile/src/features/registration/param/create_user_param.dart';
import 'package:acces_make_mobile/src/ui_kit/ui_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController _nameController;
  late TextEditingController _sureNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _visitReasonController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _sureNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _visitReasonController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sureNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _visitReasonController.dispose();
    super.dispose();
  }

  VoidCallback _createUser(BuildContext context) => () {
        final String id = const Uuid().v4();
        context.read<RegistrationBloc>().add(
              CreateUserEvent(
                CreateUserParam(
                  name: _nameController.text,
                  emailAddress: _emailController.text,
                  phone: _phoneController.text,
                  visitReason: _visitReasonController.text,
                  sureName: _sureNameController.text,
                  id: id,
                ),
              ),
            );
      };

  _registrationListener(BuildContext context, RegistrationState state) {
    switch (state) {
      case RegistationError():
        return snackBarBuilder(
          context,
          SnackBarOptions(
            title: state.error,
            type: SnackBarType.error,
          ),
        );

      case RegistationSuccess():
        {
          context.router.maybePop();
          return snackBarBuilder(
            context,
            SnackBarOptions(
              title: 'Success!',
              type: SnackBarType.success,
            ),
          );
        }

      default:
        break;
    }
  }




 String?  _validator(String? value) {
  if(value==null || value.isEmpty){
    return 'Пожалуйста введите значения';
  }
  return null;
} 

final _registerFormField= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _registerFormField,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Введите информацию о себе',
                    style: AppFonts.displayLarge.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    label: 'Введите имя',
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    validator: _validator,
                  
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Введите Фамилию',
                    controller: _sureNameController,
                    textInputAction: TextInputAction.next,
                    validator: _validator,

                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Введите почту',
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    validator: _validator,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Введите Номер',
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [InternationalPhoneFormatter()],
                    validator: _validator,

                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    textInputAction: TextInputAction.next,
                    label: 'Введите причину посещения',
                    controller: _visitReasonController,
                    validator: _validator,
                    
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<RegistrationBloc, RegistrationState>(
                      listener: _registrationListener,
                      builder: (context, state) {
                        return switch (state) {
                          RegistationInitial() || RegistationSuccess() => AppButton(
                              onPressed: _createUser(context),
                              child: Text(
                                'Продолжить',
                                style: AppFonts.displayMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          RegistationError() => AppButton(
                              onPressed: _createUser(context),
                              child: Text(
                                'Попробуйте снова',
                                style: AppFonts.displayMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          RegistationLoading() => const AppButton(
                              isLoading: true,
                            ),
                        };
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
