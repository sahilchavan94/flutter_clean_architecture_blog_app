import 'dart:io';
import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, String>> profileGeneralUpload(
      File file, String uniquePath);
  Future<Either<Failure, String>> updateProfilePicture(
      String uid, String imagePath);
}
