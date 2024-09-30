class UserModel {
  final String email;
  final String id;
  final String name;
  final String surName;
  final String phone;
  final String? biometricData;
  final String visitReason;
  UserModel({
    required this.email,
    required this.id,
    required this.name,
    required this.phone,
    required this.surName,
    required this.visitReason,
    this.biometricData
    ,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      surName: json['surName'],
      biometricData: json['biometricData'],
      visitReason: json['visitReason'],
    );
  }
}
