import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetPosterDataUseCase {
  final BlogRepository blogRepository;
  GetPosterDataUseCase({required this.blogRepository});

  Future<Either<Failure, UserEntity>> call(String posterId) async {
    return await blogRepository.getPosterData(posterId);
  }
}
