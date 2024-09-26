import 'package:acces_make_mobile/core/utils/params.dart';

class CreateUserParam extends Params {
  final String name;
  final String phone;
  final String sureName;
  final String emailAddress;
  final String visitReason;

  CreateUserParam({
    required this.emailAddress,
    required this.name,
    required this.phone,
    required this.sureName,
    required this.visitReason,
  });
  @override
  Map<String, dynamic> toData() {
    return {
      'visitReason': visitReason,
      'name': name,
      'sureName': sureName,
      'phone': phone,
      'email': emailAddress,
    };
  }
}
