import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, List<String>>> uploadBlogImages(
    List<File?> imageList,
    String uniquePath,
  );
  Future<Either<Failure, String>> uploadBlog(
    String uid,
    String posterId,
    String posterName,
    String posterImageUrl,
    String blogTitle,
    String blogSubTitle,
    String blogContent,
    List<String> blogCategories,
    List<String> blogImageUrls,
  );

  Future<Either<Failure, List<BlogEntity>>> getAllBlogs();
  Future<Either<Failure, UserEntity>> getPosterData(String posterId);
}
