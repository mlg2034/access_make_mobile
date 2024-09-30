import 'package:acces_make_mobile/src/features/registration/param/create_user_param.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
@injectable
class RegisterRepository {
  final userCollention = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(CreateUserParam params) async {
    final CollectionReference user = userCollention;
    await user.doc(params.id).set(params.toData());
  }
}
