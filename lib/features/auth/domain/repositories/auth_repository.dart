import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserCredential>> signUpWithEmailAndPassword(
    String firstname,
    String lastname,
    String email,
    String password,
  );
  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<Failure, UserEntity>> getCurrentUserData();
  Future<Either<Failure, String>> updateCurrentUserInterests(
      List<String> selectedCategories);
  Future<Either<Failure, String>> signOut();
}
