import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart';

abstract class Loanrepository {
  Future<Either<String, FirebaseException>> saveLoandata(String userId);
}
