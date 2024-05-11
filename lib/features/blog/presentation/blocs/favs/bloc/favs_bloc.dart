import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/usecases/add_blog_to_favs.dart';
import 'package:blog_app/features/blog/domain/usecases/check_blog_in_favs.dart';
import 'package:meta/meta.dart';

part 'favs_event.dart';
part 'favs_state.dart';

class FavsBloc extends Bloc<FavsEvent, FavsState> {
  final AddBlogToFavsUseCase _addBlogToFavs;
  final CheckBlogInFavsUseCase _blogInFavsUseCase;
  FavsBloc(
    this._addBlogToFavs,
    this._blogInFavsUseCase,
  ) : super(FavsInitial()) {
    on<FavsAddToFavsEvent>(_favsAddToFavsEvent);
    on<FavsCheckInFavsEvent>(_favsCheckInFavsEvent);
  }

  FutureOr<void> _favsAddToFavsEvent(
      FavsAddToFavsEvent event, Emitter<FavsState> emit) async {
    emit(FavsAddToFavsLoading());
    final response = await _addBlogToFavs.call(event.blogModel);
    response.fold(
      (l) {
        emit(
          FavsAddToFavsFailure(
            msg: l.message?.split(":")[1] ?? 'Something went wrong',
          ),
        );
      },
      (r) {
        emit(FavsAddToFavsSuccess());
      },
    );
  }

  FutureOr<void> _favsCheckInFavsEvent(
      FavsCheckInFavsEvent event, Emitter<FavsState> emit) async {
    final response = await _blogInFavsUseCase.call(event.uid);
    response.fold(
      (l) {
        emit(FavsCheckFailure());
      },
      (r) {
        emit(FavsCheckSuccess(
          r,
        ));
      },
    );
  }
}
