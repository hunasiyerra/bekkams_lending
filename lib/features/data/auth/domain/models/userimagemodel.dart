import 'package:bekkams_lending/features/data/auth/domain/entities/userimagedata.dart';

class Userimagemodel extends Userimagedata {
  Userimagemodel({
    required super.pan,
    required super.aadhar,
    required super.profileUrl,
    required super.panUrl,
    required super.aadharUrl,
  });

  factory Userimagemodel.fromJson(Map<String, dynamic> json) {
    return Userimagemodel(
      pan: json["pan"],
      aadhar: json["aadhar"],
      profileUrl: json["profileUrl"],
      panUrl: json["panUrl"],
      aadharUrl: json["aadharUrl"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "pan": pan,
      "aadhar": aadhar,
      "profileUrl": profileUrl,
      "panUrl": panUrl,
      "aadharUrl": aadharUrl,
    };
  }
}
