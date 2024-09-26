part of 'registation_bloc.dart';

sealed class RegistrationState {}

final class RegistationInitial extends RegistrationState {}
final class RegistationLoading extends RegistrationState{}

final class RegistationError extends RegistrationState{
  final String error;
  RegistationError(this.error);
}

final class RegistationSuccess extends RegistrationState{}