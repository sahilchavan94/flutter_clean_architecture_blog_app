import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:blog_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl({required this.profileRemoteDataSource});
  @override
  Future<Either<Failure, String>> profileGeneralUpload(
      File file, String uniquePath) async {
    try {
      final response =
          await profileRemoteDataSource.generalUpload(file, uniquePath);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, String>> updateProfilePicture(
      String uid, String imagePath) async {
    try {
      final response =
          await profileRemoteDataSource.updateProfilePicture(uid, imagePath);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }
}
