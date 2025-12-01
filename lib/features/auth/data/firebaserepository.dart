import 'package:firebase_auth/firebase_auth.dart';

abstract class Firebaserepository {
  Future<User?> signUp(String email, String password);
}
