import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel({
    required super.uid,
    required super.blogTitle,
    required super.blogSubTitle,
    required super.blogContent,
    required super.blogCategories,
    required super.imageUrlList,
    required super.posterId,
    required super.posterName,
    required super.posterImageUrl,
    super.date,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      uid: json['uid'] ?? '',
      posterId: json['posterId'] ?? '',
      posterName: json['poster_name'] ?? '',
      posterImageUrl: json['poster_image_url'] ?? '',
      blogTitle: json['blog_title'] ?? '',
      blogSubTitle: json['blog_sub_title'] ?? '',
      blogContent: json['blog_content'] ?? '',
      blogCategories: json['blog_categories'] ?? [],
      imageUrlList: json['blog_image_url_list'] ?? [],
      date: json['date'] ?? '',
    );
  }
}
