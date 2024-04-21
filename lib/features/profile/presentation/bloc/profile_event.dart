part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfilePictureUpload extends ProfileEvent {
  final File imageFile;
  final String imagePath;
  ProfilePictureUpload({
    required this.imageFile,
    required this.imagePath,
  });
}
