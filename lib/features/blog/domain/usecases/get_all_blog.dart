import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogUseCase {
  final BlogRepository blogRepository;
  GetAllBlogUseCase({required this.blogRepository});

  Future<Either<Failure, List<BlogEntity>>> call() async {
    return await blogRepository.getAllBlogs();
  }
}
