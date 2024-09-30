import 'package:acces_make_mobile/core/utils/params.dart';

class CreateUserParam extends Params {
  final String name;
  final String phone;
  final String sureName;
  final String emailAddress;
  final String visitReason;
  final String id;
  final String? biometricData;
  CreateUserParam({
    required this.emailAddress,
    required this.name,
    required this.phone,
    required this.sureName,
    required this.visitReason,
    required this.id,
    this.biometricData,
  });
  @override
  Map<String, dynamic> toData() {
    return {
      'visitReason': visitReason,
      'name': name,
      'sureName': sureName,
      'phone': phone,
      'email': emailAddress,
      'id':id,
      'biometricData':biometricData,
    };
  }
}
