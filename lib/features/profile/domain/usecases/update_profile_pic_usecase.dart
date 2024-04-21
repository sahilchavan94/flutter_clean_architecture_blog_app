import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateProfilePictureUseCase {
  ProfileRepository profileRepository;
  UpdateProfilePictureUseCase({required this.profileRepository});

  Future<Either<Failure, String>> call(String uid, String imageUrl) async {
    return await profileRepository.updateProfilePicture(uid, imageUrl);
  }
}
