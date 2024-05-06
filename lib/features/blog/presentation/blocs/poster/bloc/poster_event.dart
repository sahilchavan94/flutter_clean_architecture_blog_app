part of 'poster_bloc.dart';

@immutable
sealed class PosterEvent {}

class PosterFetchPosterDataEvent extends PosterEvent {
  final String posterId;
  PosterFetchPosterDataEvent({required this.posterId});
}
