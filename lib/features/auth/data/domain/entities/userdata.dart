import 'package:bekkams_lending/features/auth/data/domain/entities/userimagedata.dart';

class Userdata {
  final String uId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? phoneNumber;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Userimagedata>? userimagedata;

  Userdata({
    required this.uId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.userimagedata,
    this.createdAt,
    this.updatedAt,
  });
}
