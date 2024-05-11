import 'dart:io';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_datasource.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSourceImpl blogRemoteDataSource;
  final BlogLocalDataSourceImpl blogLocalDataSource;
  BlogRepositoryImpl({
    required this.blogRemoteDataSource,
    required this.blogLocalDataSource,
  });
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
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      final response = await blogRemoteDataSource.getAllBlogs();
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getPosterData(String posterId) async {
    try {
      final response = await blogRemoteDataSource.getPosterData(posterId);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, String>> addBlogToFavourites(BlogModel blog) async {
    try {
      final response = await blogLocalDataSource.addBlogToFavs(blog);
      return right(response);
    } on Exception catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> checkBlogInFavs(String uid) async {
    try {
      final response = await blogLocalDataSource.checkBlogInFavs(uid);
      return right(response);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllFavs() async {
    try {
      final response = await blogLocalDataSource.getAllFavs();
      return right(response);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
