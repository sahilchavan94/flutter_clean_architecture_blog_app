part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

class BlogUploadBlogEvent extends BlogEvent {
  final UploadBlogParams uploadBlogParams;
  BlogUploadBlogEvent({
    required this.uploadBlogParams,
  });
}

class BlogFetchBlogEvent extends BlogEvent {
  final String uid;
  BlogFetchBlogEvent({required this.uid});
}
