import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class SignUp {
  AuthRepository authRepository;
  SignUp(this.authRepository);

  Future<Either<Failure, UserCredential>> call(
      String firstname, String lastname, String email, String password) async {
    return await authRepository.signUpWithEmailAndPassword(
      firstname,
      lastname,
      email,
      password,
    );
  }
}
