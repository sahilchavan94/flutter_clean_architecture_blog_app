import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddBlogToFavsUseCase {
  final BlogRepository blogRepository;
  AddBlogToFavsUseCase({required this.blogRepository});

  Future<Either<Failure, String>> call(BlogModel blog) async {
    return await blogRepository.addBlogToFavourites(blog);
  }
}
