import 'dart:io';

import 'package:bekkams_lending/features/auth/data/domain/entities/userimagedata.dart';
import 'package:bekkams_lending/features/auth/data/domain/models/userdatamodel.dart';
import 'package:bekkams_lending/features/auth/data/domain/models/userimagemodel.dart';
import 'package:bekkams_lending/features/auth/data/firebaserepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';

class Firebaserepositoryimpl extends Firebaserepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Firebaserepositoryimpl() {
    print("repository object created");
  }

  @override
  Future<Either<User?, FirebaseException>> signUp(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // print("This is use id:${userCredential.user!.uid}");
      // print("This is current user: ${_auth.currentUser!.uid}");
      return left(userCredential.user);
    } on FirebaseException catch (e) {
      return right(e);
    }
  }

  @override
  Future<Either<String, FirebaseException>> saveUserdata(
    Userdatamodel userdatamodel,
  ) async {
    try {
      await _firebaseFirestore
          .collection("Users")
          .doc(userdatamodel.uId)
          .set(userdatamodel.toJson());
      return left("Data Saved Successfully");
    } on FirebaseException catch (e) {
      return right(e);
    }
  }

  @override
  Future<Either<String, FirebaseException>> uploadImage(
    String uid,
    String folder,
    File file,
  ) async {
    try {
      final Reference ref = _storage
          .ref()
          .child("Image")
          .child(uid)
          .child(folder);
      final UploadTask uploadTask = ref.putFile(file);

      // Wait for upload to complete
      final TaskSnapshot snapshot = await uploadTask;

      final String url = await snapshot.ref.getDownloadURL();
      return left(url);
    } on FirebaseAuthException catch (e) {
      return right(e);
    }
  }

  @override
  Future<Either<String, FirebaseException>> uploadImagedata(
    String uid,
    List<Userimagedata> userimagedata,
  ) async {
    try {
      await _firebaseFirestore.collection("Users").doc(uid).update({
        'images': userimagedata.map((e) => (e as Userimagemodel).toJson()),
      });
      return left("Data Saved Successfully");
    } on FirebaseException catch (e) {
      return right(e);
    }
  }
}
