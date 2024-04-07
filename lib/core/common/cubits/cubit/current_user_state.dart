part of 'current_user_cubit.dart';

@immutable
sealed class CurrentUserState {}

final class CurrentUserInitial extends CurrentUserState {}

final class CurrentUserDataFetched extends CurrentUserState {
  final UserEntity userEntity;
  CurrentUserDataFetched(this.userEntity);
}
