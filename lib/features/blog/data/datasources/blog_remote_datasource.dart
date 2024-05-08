import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

abstract interface class BlogRemoteDataSource {
  Future<List<String>> uploadBlogImages(
    List<File> imageList,
    String uniquePath,
  );
  Future<String> uploadBlog(
    String uid,
    String posterId,
    String posterName,
    String posterImageUrl,
    String blogTitle,
    String blogSubTitle,
    String blogContent,
    List<String> blogCategories,
    List<String> blogImageUrls,
  );

  Future<List<BlogEntity>> getAllBlogs();
  Future<UserEntity> getPosterData(String posterId);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  FirebaseStorage firebaseStorage;
  FirebaseDatabase firebaseDatabase;

  BlogRemoteDataSourceImpl({
    required this.firebaseDatabase,
    required this.firebaseStorage,
  });

  @override
  Future<List<String>> uploadBlogImages(
      List<File?> imageList, String uniquePath) async {
    List<String> imageUrls = List.filled(imageList.length, "");
    int index = 0;

    try {
      // ignore: avoid_function_literals_in_foreach_calls
      for (int i = 0; i < imageList.length; i++) {
        var imagePathRef = firebaseStorage
            .ref()
            .child('blogImages/$uniquePath/$uniquePath$index');
        var response = await imagePathRef.putFile(imageList[i]!);
        var imageUrl = await response.ref.getDownloadURL();
        imageUrls[index] = imageUrl;
        index += 1;
      }
      return imageUrls;
    } catch (e) {
      throw ServerException(error: e.toString());
    }
  }

  @override
  Future<String> uploadBlog(
    String uid,
    String posterId,
    String posterName,
    String posterImageUrl,
    String blogTitle,
    String blogSubTitle,
    String blogContent,
    List<String> blogCategories,
    List<String> blogImageUrls,
  ) async {
    try {
      await firebaseDatabase.ref("blogs").child(uid).set({
        'uid': uid,
        'posterId': posterId,
        'blog_title': blogTitle,
        'blog_sub_title': blogSubTitle,
        'blog_content': blogContent,
        'blog_categories': blogCategories,
        'blog_image_url_list': blogImageUrls,
        'likes': 0,
        'date': DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now()),
      });
      return "Blog uploaded successfully";
    } catch (e) {
      throw ServerException(error: e.toString());
    }
  }

  @override
  Future<List<BlogEntity>> getAllBlogs() async {
    try {
      final raw = await firebaseDatabase.ref("blogs").once();
      final response = jsonDecode(jsonEncode(raw.snapshot.value));
      if (response != null) {
        final blogList =
            (response as Map<String, dynamic>).entries.map((blog) async {
          final posterId = blog.value['posterId'];
          final raw2 =
              await firebaseDatabase.ref("users").child(posterId).once();
          final posterResponse = jsonDecode(
            jsonEncode(raw2.snapshot.value),
          );
          return BlogModel.fromJson(blog.value).copyWith(
            userEntity: UserModel.fromJson(posterResponse),
          );
        }).toList();
        final list = Future.wait(blogList);
        return list;
      }
      return [];
    } catch (e) {
      log("err is ${e.toString()}");
      throw ServerException(error: e.toString());
    }
  }

  @override
  Future<UserEntity> getPosterData(String posterId) async {
    try {
      final response =
          await firebaseDatabase.ref("users").child(posterId).once();

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
}
