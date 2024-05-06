import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/blog/domain/usecases/get_poster_data.dart';
import 'package:meta/meta.dart';

part 'poster_event.dart';
part 'poster_state.dart';

class PosterBloc extends Bloc<PosterEvent, PosterState> {
  final GetPosterDataUseCase _getPosterDataUseCase;
  PosterBloc(
    this._getPosterDataUseCase,
  ) : super(PosterInitial()) {
    on<PosterFetchPosterDataEvent>(_posterFetchPosterDataEvent);
  }

  FutureOr<void> _posterFetchPosterDataEvent(
      PosterFetchPosterDataEvent event, Emitter<PosterState> emit) async {
    emit(PosterDataLoading());
    final response = await _getPosterDataUseCase.call(event.posterId);
    response.fold(
      (l) {
        emit(
          PosterDataFailure(message: l.message ?? 'Something went wrong'),
        );
      },
      (r) {
        emit(PosterDataSuccess(poster: r));
      },
    );
  }
}
