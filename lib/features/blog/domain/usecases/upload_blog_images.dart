import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogImagesUseCase {
  final BlogRepository blogRepository;
  UploadBlogImagesUseCase({required this.blogRepository});

  Future<Either<Failure, List<String>>> call(
      List<File?> imageList, String uniquePath) async {
    return await blogRepository.uploadBlogImages(imageList, uniquePath);
  }
}
