import 'dart:io';

import 'package:blog_app/core/utils/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditBlogManager extends ChangeNotifier {
  late List<File?> blogImageList;
  TextEditingController blogTitle = TextEditingController();
  TextEditingController blogSubTitle = TextEditingController();

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
}
