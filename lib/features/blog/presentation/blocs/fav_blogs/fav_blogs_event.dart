part of 'fav_blogs_bloc.dart';

@immutable
sealed class FavBlogsEvent {}

class FavBlogsGetAllFavsEvent extends FavBlogsEvent {}
