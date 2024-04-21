import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class SignInUseCase {
  AuthRepository authRepository;
  SignInUseCase(this.authRepository);

  Future<Either<Failure, UserCredential>> call(
      String email, String password) async {
    return await authRepository.signInWithEmailAndPassword(email, password);
  }
}
