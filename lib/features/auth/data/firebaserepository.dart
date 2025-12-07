import 'package:bekkams_lending/features/auth/data/domain/models/userdatamodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract class Firebaserepository {
  Future<Either<User?, FirebaseException>> signUp(
    String email,
    String password,
  );
  Future<Either<String, FirebaseException>> saveUserdata(
    Userdatamodel userdatamodel,
  );
}
