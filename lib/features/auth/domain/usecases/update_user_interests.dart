import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateCurrentUserInterests {
  AuthRepository authRepository;
  UpdateCurrentUserInterests(this.authRepository);

  Future<Either<Failure, String>> call(List<String> selectedCategories) async {
    return await authRepository.updateCurrentUserInterests(selectedCategories);
  }
}
