// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:blog_app/features/auth/domain/entities/user_entity.dart';

class BlogEntity {
  final String uid;
  final String posterId;
  final String posterName;
  final String posterImageUrl;
  final String blogTitle;
  final String blogSubTitle;
  final String blogContent;
  final List blogCategories;
  final List imageUrlList;
  final String? date;
  final UserEntity? userEntity;
  final int? likes;
  BlogEntity({
    required this.uid,
    required this.posterId,
    required this.posterName,
    required this.posterImageUrl,
    required this.blogTitle,
    required this.blogSubTitle,
    required this.blogContent,
    required this.blogCategories,
    required this.imageUrlList,
    this.userEntity,
    this.date,
    this.likes,
  });

  BlogEntity copyWith({
    UserEntity? userEntity,
    int? likes,
  }) {
    return BlogEntity(
      uid: uid,
      posterId: posterId,
      posterName: posterName,
      posterImageUrl: posterImageUrl,
      blogTitle: blogTitle,
      blogSubTitle: blogSubTitle,
      blogContent: blogContent,
      blogCategories: blogCategories,
      imageUrlList: imageUrlList,
      date: date ?? date,
      userEntity: userEntity ?? this.userEntity,
      likes: likes ?? this.likes,
    );
  }
}
