import 'dart:async';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/profile/domain/usecases/profile_general_upload_usecase.dart';
import 'package:blog_app/features/profile/domain/usecases/update_profile_pic_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileGeneralUploadUseCase _profileGeneralUploadUseCase;
  final UpdateProfilePictureUseCase _updateProfilePictureUseCase;
  ProfileBloc(
    this._profileGeneralUploadUseCase,
    this._updateProfilePictureUseCase,
  ) : super(ProfileInitial()) {
    on<ProfilePictureUpload>(_profilePictureUpload);
  }

  FutureOr<void> _profilePictureUpload(
      ProfilePictureUpload event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      //upload the image to the storage
      final response = await _profileGeneralUploadUseCase.call(
        event.imageFile,
        event.imagePath,
      );

      if (response.isRight()) {
        final profileImageResponse = await _updateProfilePictureUseCase.call(
          event.imagePath,
          response.getRight().getOrElse(() => 'null'),
        );

        profileImageResponse.fold(
          (l) => emit(ProfileFailure()),
          (r) => emit(ProfileSuccess()),
        );
        return;
      }
      emit(ProfileFailure());
    } on ServerException {
      emit(ProfileFailure());
    }
  }
}
