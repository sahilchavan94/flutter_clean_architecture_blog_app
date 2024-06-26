import 'dart:io';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditBlogManager extends ChangeNotifier {
  late List<File?> blogImageList;
  TextEditingController blogTitle = TextEditingController();
  TextEditingController blogSubTitle = TextEditingController();
  TextEditingController blogContent = TextEditingController();
  List<String> blogCategories = [];
  int currentImage = 0;
  int currentBlogImage = 0;

  EditBlogManager() {
    blogImageList = List.filled(3, null);
  }

  void addImageToBlogImageList(ImageSource imageSource, int index) async {
    final pickedImage = await PickImage.pickImage(imageSource);
    if (pickedImage != null) {
      blogImageList[index] = pickedImage;
    }
    notifyListeners();
  }

  void removeImageFromBlogImageList(int index) {
    blogImageList[index] = null;
    notifyListeners();
  }

  void handleCategory(String category) {
    if (blogCategories.contains(category)) {
      blogCategories.remove(category);
    } else {
      blogCategories.add(category);
    }
    notifyListeners();
  }

  void handleCurrentIndex(int index) {
    currentImage = index;
    notifyListeners();
  }

  void handleCurrentBlogIndex(int index) {
    currentBlogImage = index;
    notifyListeners();
  }

  void resetIndexes() {
    currentImage = 0;
    currentBlogImage = 0;
    notifyListeners();
  }

  String validateBlog() {
    if (blogTitle.text.isEmpty) {
      return "Blog title cannot be empty";
    } else if (blogTitle.text.length < 6) {
      return "Blog title should be at least 6 characters long";
    }

    if (blogSubTitle.text.isEmpty) {
      return "Blog subtitle cannot be empty";
    } else if (blogSubTitle.text.length < 6) {
      return "Blog subtitle should be at least 6 characters long";
    }

    if (blogContent.text.isEmpty) {
      return "Blog content cannot be empty";
    } else if (blogContent.text.length < 50) {
      return "Blog content should be at least 50 characters long";
    }

    if (blogImageList[0] == null) {
      return "Add main image to the blog";
    }

    if (blogCategories.isEmpty) {
      return "Please select at least one category for the blog";
    }

    return "";
  }

  void resetEditBlog() {
    blogImageList = [];
    blogTitle.dispose();
    blogSubTitle.dispose();
    blogContent.dispose();
    blogCategories = [];
    resetIndexes();
    notifyListeners();
  }
}
