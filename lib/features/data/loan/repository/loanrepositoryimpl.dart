import 'package:bekkams_lending/features/data/firebaseinstance.dart';
import 'package:bekkams_lending/features/data/loan/repository/loanrepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

class Loanrepositoryimpl extends Loanrepository {
  final FirebaseFirestore _firestore;

  Loanrepositoryimpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? Firebaseinstance.firestore;

  @override
  Future<Either<String, FirebaseException>> saveLoandata(String userId) {
    // TODO: implement saveLoandata
    throw UnimplementedError();
  }
}
