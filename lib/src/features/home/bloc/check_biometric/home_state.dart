part of 'home_bloc.dart';

sealed class CheckBiometricState {}

final class ChechBiometricInitial extends CheckBiometricState {}
final class CheckBiometricLoading extends CheckBiometricState {}

final class CheckBiometricError extends CheckBiometricState{
  final String error;
  CheckBiometricError(this.error);
}

final class CheckBiometricSuccess extends CheckBiometricState{}

final class NotIndentified extends CheckBiometricState{}
