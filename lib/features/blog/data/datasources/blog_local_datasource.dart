import 'dart:developer';

import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract interface class BlogLocalDataSource {
  Future<String> addBlogToFavs(BlogModel blog);
  Future<bool> checkBlogInFavs(String uid);
  Future<List<BlogEntity>> getAllFavs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl({required this.box});
  @override
  Future<String> addBlogToFavs(BlogModel blog) async {
    final List currentBlogFavsList = await box.get('current_favs_list') ?? [];

    for (int i = 0; i < currentBlogFavsList.length; i++) {
      if (currentBlogFavsList[i]['uid'] == blog.uid) {
        return throw Exception("Blog is already added to favourites");
      }
    }

    final newList = currentBlogFavsList.append(blog.toJson()).toList();
    try {
      await box.put(
        'current_favs_list',
        newList,
      );
      return "Successfully added to favourites";
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<BlogEntity>> getAllFavs() async {
    final addedBlogs = await box.get('current_favs_list');
    List<BlogEntity> blogs = [];
    if (addedBlogs == null || addedBlogs.isEmpty) {
      throw Exception("Something went wrong");
    }
    try {
      for (int i = 0; i < (addedBlogs as List<dynamic>).length; i++) {
        BlogEntity blog = BlogModel.fromJson(addedBlogs[i]);
        blogs.add(blog);
      }
      return blogs;
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }

  @override
  Future<bool> checkBlogInFavs(String uid) async {
    final List currentBlogFavsList = await box.get('current_favs_list') ?? [];

    if (currentBlogFavsList.isEmpty) {
      return false;
    }

    for (int i = 0; i < currentBlogFavsList.length; i++) {
      if (currentBlogFavsList[i]['uid'] == uid) {
        return true;
      }
    }

    return false;
  }
}
