import 'dart:io';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract interface class ProfileRemoteDataSource {
  Future<String> generalUpload(File file, String path);
  Future<String> updateProfilePicture(String uid, String imageUrl);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  FirebaseStorage firebaseStorage;
  FirebaseDatabase firebaseDatabase;

  ProfileRemoteDataSourceImpl({
    required this.firebaseDatabase,
    required this.firebaseStorage,
  });

  // for adding the profile picture to the firebase storage
  @override
  Future<String> generalUpload(File file, String uniquePath) async {
    final profilePathRef =
        firebaseStorage.ref().child('profileimages/$uniquePath');
    try {
      final response = await profilePathRef.putFile(file);
      //return the uploaded profile url
      return response.ref.getDownloadURL();
    } catch (e) {
      throw ServerException(error: e.toString());
    }
  }

  //for updating the url in database
  @override
  Future<String> updateProfilePicture(String uid, String imageUrl) async {
    try {
      await firebaseDatabase.ref("users").child(uid).update(
        {'profile_image_url': imageUrl},
      );
      return 'Profile picture updated';
    } catch (e) {
      throw ServerException(error: e.toString());
    }
  }
}
