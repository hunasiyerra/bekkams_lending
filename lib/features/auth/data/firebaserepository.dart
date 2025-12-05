import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract class Firebaserepository {
  Future<Either<User?, FirebaseException>> signUp(
    String email,
    String password,
  );
}
