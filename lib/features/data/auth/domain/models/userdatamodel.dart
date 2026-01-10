import 'package:bekkams_lending/features/data/auth/domain/entities/userdata.dart';
import 'package:bekkams_lending/features/data/auth/domain/models/userimagemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      phoneNumber: (json['phoneNumber'] as num?)?.toInt(),
      role: json['role'],
      userimagedata:
          (json['images'] as List<dynamic>?)
              ?.map((e) => Userimagemodel.fromJson(e))
              .toList(),
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  factory Userdatamodel.fromEntity(Userdata entity) {
    return Userdatamodel(
      uId: entity.uId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      role: entity.role,
      userimagedata: entity.userimagedata,
      createdAt: entity.createdAt,
      updatedAt: DateTime.now(),
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
      'images': userimagedata?.map((e) => (e as Userimagemodel).toJson()) ?? [],
      'createdAt': createdAt ?? "",
      'updatedAt': updatedAt ?? DateTime.now(),
    };
  }
}
