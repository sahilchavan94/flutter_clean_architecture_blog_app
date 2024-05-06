part of 'poster_bloc.dart';

@immutable
sealed class PosterState {}

final class PosterInitial extends PosterState {}

final class PosterDataLoading extends PosterState {}

final class PosterDataFailure extends PosterState {
  final String message;

  PosterDataFailure({
    required this.message,
  });
}

final class PosterDataSuccess extends PosterState {
  final UserEntity poster;

  PosterDataSuccess({
    required this.poster,
  });
}
