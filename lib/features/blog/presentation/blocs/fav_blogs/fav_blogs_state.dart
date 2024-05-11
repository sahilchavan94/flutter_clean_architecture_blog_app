part of 'fav_blogs_bloc.dart';

@immutable
sealed class FavBlogsState {}

final class FavBlogsInitial extends FavBlogsState {}

final class FavBlogsGetFavsLoading extends FavBlogsState {}

final class FavBlogsGetFavsFailure extends FavBlogsState {}

final class FavBlogsGetFavsSuccess extends FavBlogsState {
  final List<BlogEntity> blogList;
  FavBlogsGetFavsSuccess({required this.blogList});
}
