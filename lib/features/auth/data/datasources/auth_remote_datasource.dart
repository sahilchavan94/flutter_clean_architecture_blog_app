import 'dart:convert';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/firebase_database.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserCredential> signUpWithEmailAndPassword(
    String firstname,
    String lastname,
    String email,
    String password,
  );
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<UserModel> getCurrentUserData();
  Future<String?> updateCurrentUserInterests(List<String> interestedCategories);
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseDatabase firebaseDatabase;
  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseDatabase,
  });

  @override
  Future<UserModel> getCurrentUserData() async {
    try {
      if (firebaseAuth.currentUser == null) {
        throw const ServerException(error: "User not logged in");
      }
      final response = await firebaseDatabase
          .ref("users")
          .child(firebaseAuth.currentUser!.uid)
          .once();

      //return the user model
      return UserModel.fromJson(
        jsonDecode(
          jsonEncode(response.snapshot.value),
        ),
      );
    } catch (e) {
      throw ServerException(error: e.toString());
    }
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword(
      String firstname, String lastname, String email, String password) async {
    try {
      //create a new user in authentication
      final res = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //if the user creation fails
      if (res.user == null) {
        return throw const ServerException(error: "Failed to create user");
      }

      //create a new user record in the realtime database as well
      await firebaseDatabase.ref("users").child(res.user!.uid).set({
        'firstname': firstname.toLowerCase(),
        'lastname': lastname.toLowerCase(),
        'email': email.toLowerCase(),
        'uid': firebaseAuth.currentUser!.uid,
        'profile_image_url': "",
      });

      return res;
    } catch (e) {
      throw ServerException(error: e.toString());
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      //login with firebase auth
      final res = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (res.user == null) {
        throw const ServerException(error: "Failed to sign in");
      }
      return res;
    } catch (e) {
      throw ServerException(error: e.toString());
    }
  }

  @override
  Future<String?> updateCurrentUserInterests(
      List<String> interestedCategories) async {
    try {
      if (firebaseAuth.currentUser == null) {
        throw const ServerException(error: "User not logged in");
      }
      return await firebaseDatabase
          .ref("users")
          .child(firebaseAuth.currentUser!.uid)
          .update({
        'interested_categories': interestedCategories,
      }).then((value) => "User interests are updated");
    } catch (e) {
      throw ServerException(error: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      if (firebaseAuth.currentUser == null) {
        throw const ServerException(error: "User is already logged out");
      }
      await firebaseAuth.signOut();
    } catch (e) {
      throw ServerException(error: e.toString());
    }
  }
}
