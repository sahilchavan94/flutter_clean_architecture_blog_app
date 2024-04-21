import 'dart:io';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProfileGeneralUploadUseCase {
  ProfileRepository profileRepository;
  ProfileGeneralUploadUseCase({required this.profileRepository});

  Future<Either<Failure, String>> call(File file, String uniquePath) async {
    return await profileRepository.profileGeneralUpload(file, uniquePath);
  }
}
