import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_favs.dart';
import 'package:meta/meta.dart';

part 'fav_blogs_event.dart';
part 'fav_blogs_state.dart';

class FavBlogsBloc extends Bloc<FavBlogsEvent, FavBlogsState> {
  final GetAllFavsUseCase _getAllFavsUseCase;
  FavBlogsBloc(
    this._getAllFavsUseCase,
  ) : super(FavBlogsInitial()) {
    on<FavBlogsGetAllFavsEvent>(_favBlogsGetAllFavsEvent);
  }

  FutureOr<void> _favBlogsGetAllFavsEvent(
      FavBlogsGetAllFavsEvent event, Emitter<FavBlogsState> emit) async {
    emit(FavBlogsGetFavsLoading());
    final response = await _getAllFavsUseCase.call();
    response.fold(
      (l) => emit(FavBlogsGetFavsFailure()),
      (r) => emit(FavBlogsGetFavsSuccess(
        blogList: r,
      )),
    );
  }
}
