import 'package:bekkams_lending/features/auth/data/firebaserepository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebaserepositoryimpl extends Firebaserepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential.toString());
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
