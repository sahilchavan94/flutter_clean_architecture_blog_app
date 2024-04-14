import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, UserCredential>> signUpWithEmailAndPassword(
      String firstname, String lastname, String email, String password) async {
    try {
      final response = await authRemoteDataSource.signUpWithEmailAndPassword(
          firstname, lastname, email, password);
      return right(response);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.error.split("] ")[1],
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final response = await authRemoteDataSource.signInWithEmailAndPassword(
          email, password);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.error.split("] ")[1]));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUserData() async {
    try {
      final response = await authRemoteDataSource.getCurrentUserData();
      return right(UserEntity.toEntity(response));
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, String>> signOut() async {
    try {
      await authRemoteDataSource.signOut();
      return right("User logged out");
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, String>> updateCurrentUserInterests(
      List<String> selectedCategories) async {
    try {
      await authRemoteDataSource.updateCurrentUserInterests(selectedCategories);
      return right("User logged out");
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }
}
