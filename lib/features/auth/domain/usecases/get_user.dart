import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetUser {
  AuthRepository authRepository;
  GetUser(this.authRepository);

  Future<Either<Failure, UserEntity>> call() async {
    return await authRepository.getCurrentUserData();
  }
}
