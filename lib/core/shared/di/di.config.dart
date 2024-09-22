// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../src/features/home/bloc/check_biometric/home_bloc.dart' as _i63;
import '../../../src/features/home/data/biometrick_repository.dart' as _i618;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i618.BiometrickRepository>(() => _i618.BiometrickRepository());
  gh.factory<_i63.CheckBiometricBloc>(
      () => _i63.CheckBiometricBloc(gh<_i618.BiometrickRepository>()));
  return getIt;
}
