part of 'favs_bloc.dart';

@immutable
sealed class FavsState {}

final class FavsInitial extends FavsState {}

final class FavsAddToFavsLoading extends FavsState {}

final class FavsAddToFavsFailure extends FavsState {
  final String msg;
  FavsAddToFavsFailure({required this.msg});
}

final class FavsAddToFavsSuccess extends FavsState {}

final class FavsCheckLoading extends FavsState {}

final class FavsCheckFailure extends FavsState {}

final class FavsCheckSuccess extends FavsState {
  final bool val;
  FavsCheckSuccess(this.val);
}
