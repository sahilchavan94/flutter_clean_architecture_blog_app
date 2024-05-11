import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class CheckBlogInFavsUseCase {
  final BlogRepository blogRepository;
  CheckBlogInFavsUseCase({required this.blogRepository});

  Future<Either<Failure, bool>> call(String uid) async {
    return await blogRepository.checkBlogInFavs(uid);
  }
}
