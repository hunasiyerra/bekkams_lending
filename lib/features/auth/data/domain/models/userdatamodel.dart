import 'package:bekkams_lending/features/auth/data/domain/entities/userdata.dart';

class Userdatamodel extends Userdata {
  Userdatamodel({
    required super.uId,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.role,
    super.userimagedata,
    super.createdAt,
    super.updatedAt,
  });

  factory Userdatamodel.fromJson(Map<String, dynamic> json) {
    return Userdatamodel(
      uId: json['uId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      userimagedata: json['images'] ?? '',
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'firstName': firstName ?? "",
      'lastName': lastName ?? "",
      'email': email ?? "",
      'phoneNumber': phoneNumber ?? "",
      'role': role ?? "",
      'images': userimagedata ?? [],
      'createdAt': createdAt ?? DateTime.now(),
      'updatedAt': updatedAt ?? DateTime.now(),
    };
  }
}
