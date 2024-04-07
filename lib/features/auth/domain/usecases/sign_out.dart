import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignOut {
  AuthRepository authRepository;
  SignOut(this.authRepository);

  Future<Either<Failure, String>> call() async {
    return await authRepository.signOut();
  }
}
