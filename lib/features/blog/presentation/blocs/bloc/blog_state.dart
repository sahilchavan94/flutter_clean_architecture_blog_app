part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogSuccess extends BlogState {}

final class BlogFailure extends BlogState {
  final String message;
  BlogFailure({required this.message});
}

final class BlogGetAllBlogFailure extends BlogState {
  final String message;

  BlogGetAllBlogFailure({
    required this.message,
  });
}

final class BlogGetAllBlogLoading extends BlogState {}

final class BlogGetAllBlogSuccess extends BlogState {
  final List<BlogEntity> blogList;

  BlogGetAllBlogSuccess({
    required this.blogList,
  });
}
