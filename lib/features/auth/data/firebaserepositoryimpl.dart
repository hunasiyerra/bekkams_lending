import 'package:bekkams_lending/features/auth/data/firebaserepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class Firebaserepositoryimpl extends Firebaserepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Either<User?, FirebaseException>> signUp(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return left(userCredential.user);
    } on FirebaseException catch (e) {
      return right(e);
    }
  }
}
