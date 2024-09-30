import 'package:acces_make_mobile/src/features/registration/data/register_repository.dart';
import 'package:acces_make_mobile/src/features/registration/param/create_user_param.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

part 'registation_event.dart';
part 'registation_state.dart';

@injectable
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegisterRepository _registerRepository;
  RegistrationBloc(this._registerRepository) : super(RegistationInitial()) {
    on<CreateUserEvent>(_createUser);
  }

  Future<void> _createUser(
    CreateUserEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    if (state is RegistationLoading) return;
    emit(RegistationLoading());
    try {
      _registerRepository.createUser(event.params);
      emit(
        RegistationSuccess(),
      );
    } catch (error) {
      emit(
        RegistationError(
          error.toString(),
        ),
      );
    }
  }
}
