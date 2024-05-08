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
  });

  BlogEntity copyWith({
    String? uid,
    String? posterId,
    String? posterName,
    String? posterImageUrl,
    String? blogTitle,
    String? blogSubTitle,
    String? blogContent,
    List? blogCategories,
    List? imageUrlList,
    String? date,
    UserEntity? userEntity,
  }) {
    return BlogEntity(
      uid: uid ?? this.uid,
      posterId: posterId ?? this.posterId,
      posterName: posterName ?? this.posterName,
      posterImageUrl: posterImageUrl ?? this.posterImageUrl,
      blogTitle: blogTitle ?? this.blogTitle,
      blogSubTitle: blogSubTitle ?? this.blogSubTitle,
      blogContent: blogContent ?? this.blogContent,
      blogCategories: blogCategories ?? this.blogCategories,
      imageUrlList: imageUrlList ?? this.imageUrlList,
      date: date ?? this.date,
      userEntity: userEntity ?? this.userEntity,
    );
  }
}
