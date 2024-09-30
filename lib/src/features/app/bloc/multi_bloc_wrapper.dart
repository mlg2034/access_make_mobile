import 'package:acces_make_mobile/core/shared/di/di.dart';
import 'package:acces_make_mobile/src/features/home/bloc/check_biometric/home_bloc.dart';
import 'package:acces_make_mobile/src/features/home/data/biometrick_repository.dart';
import 'package:acces_make_mobile/src/features/registration/bloc/registration/registation_bloc.dart';
import 'package:acces_make_mobile/src/features/registration/data/register_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  const MultiBlocWrapper({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckBiometricBloc>(
          create: (context) => CheckBiometricBloc(
            getIt<BiometrickRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => RegistrationBloc(
            getIt<RegisterRepository>(),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return child;
        },
      ),
    );
  }
}
