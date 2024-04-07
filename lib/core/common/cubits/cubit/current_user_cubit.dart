// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  CurrentUserCubit() : super(CurrentUserInitial());
  void updateUser(UserEntity? user) {
    print(user?.email);
    if (user == null) {
      emit(CurrentUserInitial());
    } else {
      emit(CurrentUserDataFetched(user));
    }
  }
}
