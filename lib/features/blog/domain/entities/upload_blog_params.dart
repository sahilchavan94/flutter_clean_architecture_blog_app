import 'dart:io';

class UploadBlogParams {
  final String uid;
  final String posterId;
  final String posterName;
  final String posterImageUrl;
  final String blogTitle;
  final String blogSubTitle;
  final String blogContent;
  final List<String> blogCategories;
  final List<File?> imageFileList;

  UploadBlogParams({
    required this.uid,
    required this.posterId,
    required this.posterName,
    required this.posterImageUrl,
    required this.blogTitle,
    required this.blogSubTitle,
    required this.blogContent,
    required this.blogCategories,
    required this.imageFileList,
  });
}
