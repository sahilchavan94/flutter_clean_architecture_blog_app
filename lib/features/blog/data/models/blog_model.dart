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
    super.userEntity,
    super.likes,
  });

  factory BlogModel.fromJson(Map<dynamic, dynamic> json) {
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
      userEntity: json['user_entity'],
      likes: json['likes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'posterId': posterId,
      'poster_name': posterName,
      'poster_image_url': posterImageUrl,
      'blog_title': blogTitle,
      'blog_sub_title': blogSubTitle,
      'blog_content': blogContent,
      'blog_categories': blogCategories,
      'blog_image_url_list': imageUrlList,
      'date': date,
    };
  }

  factory BlogModel.fromBlogEntity(BlogEntity blogEntity) => BlogModel(
        uid: blogEntity.uid,
        blogTitle: blogEntity.blogTitle,
        blogSubTitle: blogEntity.blogSubTitle,
        blogContent: blogEntity.blogContent,
        blogCategories: blogEntity.blogCategories,
        imageUrlList: blogEntity.imageUrlList,
        posterId: blogEntity.posterId,
        posterName: blogEntity.posterName,
        posterImageUrl: blogEntity.posterImageUrl,
        userEntity: blogEntity.userEntity,
      );
}
