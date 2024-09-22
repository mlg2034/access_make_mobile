import 'dart:developer';

import 'package:acces_make_mobile/src/features/home/data/biometrick_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
part 'home_event.dart';
part 'home_state.dart';
@injectable

class CheckBiometricBloc extends Bloc<CheckBiometricEvent, CheckBiometricState> {
  final BiometrickRepository _biometrickRepository;
  CheckBiometricBloc(this._biometrickRepository) : super(ChechBiometricInitial()) {
    on<ChechBiometri>(_checkBiometrick);
  }

  Future<void> _checkBiometrick(
    ChechBiometri event,
    Emitter<CheckBiometricState> emit,
  ) async {
    if (state is CheckBiometricLoading) return;
    emit(CheckBiometricLoading());
    try {
      final isAuthenticated = await _biometrickRepository.authWithBiometric();

      if (isAuthenticated) {
        emit(CheckBiometricSuccess());
      } else {
        emit(NotIndentified());
      }
    } catch (error) {
      emit(
        CheckBiometricError(
          error.toString(),
        ),
      );
      log('Biometric error: $error');
      throw Exception('Failed to authenticate using biometrics');
    }
  }
}
