import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignOutUseCase {
  AuthRepository authRepository;
  SignOutUseCase(this.authRepository);

  Future<Either<Failure, String>> call() async {
    return await authRepository.signOut();
  }
}
