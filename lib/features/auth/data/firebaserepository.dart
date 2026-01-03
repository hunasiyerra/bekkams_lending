import 'dart:io';
import 'package:bekkams_lending/features/auth/data/domain/entities/userdata.dart';
import 'package:bekkams_lending/features/auth/data/domain/models/userimagemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract class Firebaserepository {
  Future<Either<User?, FirebaseException>> signUp(
    String email,
    String password,
  );

  Future<Either<User?, FirebaseException>> signIn(
    String email,
    String password,
  );
  Future<Either<String, FirebaseException>> saveUserdata(Userdata userdata);

  Future<Either<String, FirebaseException>> uploadImage(
    String uid,
    String folder,
    File file,
  );

  Future<Either<String, FirebaseException>> uploadImagedata(
    String uid,
    List<Userimagemodel> userimagedata,
  );

  Future logout();

  Future<Either<Userdata?, FirebaseException>> fetchUserData(String userId);
}
