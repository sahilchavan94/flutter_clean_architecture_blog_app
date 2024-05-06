import 'dart:io';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSourceImpl blogRemoteDataSource;
  BlogRepositoryImpl({required this.blogRemoteDataSource});
  @override
  Future<Either<Failure, List<String>>> uploadBlogImages(
      List<File?> imageList, String uniquePath) async {
    try {
      final response =
          await blogRemoteDataSource.uploadBlogImages(imageList, uniquePath);
      return Right(response);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, String>> uploadBlog(
      String uid,
      String posterId,
      String posterName,
      String posterImageUrl,
      String blogTitle,
      String blogSubTitle,
      String blogContent,
      List<String> blogCategories,
      List<String> blogImageUrls) async {
    try {
      final response = await blogRemoteDataSource.uploadBlog(
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
      return Right(response);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      final response = await blogRemoteDataSource.getAllBlogs();
      return Right(response);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getPosterData(String posterId) async {
    try {
      final response = await blogRemoteDataSource.getPosterData(posterId);
      return Right(response);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }
}
