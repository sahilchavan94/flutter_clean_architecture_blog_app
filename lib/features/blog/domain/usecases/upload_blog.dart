import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUseCase {
  final BlogRepository blogRepository;
  UploadBlogUseCase({required this.blogRepository});

  Future<Either<Failure, String>> call(
    String uid,
    String posterId,
    String posterName,
    String posterImageUrl,
    String blogTitle,
    String blogSubTitle,
    String blogContent,
    List<String> blogCategories,
    List<String> blogImageUrls,
  ) async {
    return await blogRepository.uploadBlog(
      uid,
      posterId,
      posterName,
      posterImageUrl,
      blogTitle,
      blogSubTitle,
      blogContent,
      blogCategories,
      blogImageUrls,
    );
  }
}
