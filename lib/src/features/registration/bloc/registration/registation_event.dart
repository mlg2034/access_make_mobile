part of 'registation_bloc.dart';

sealed class RegistrationEvent {}


final class CreateUserEvent extends RegistrationEvent{
  final CreateUserParam params;
  CreateUserEvent(this.params);
}