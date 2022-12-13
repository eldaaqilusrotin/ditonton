import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/core.dart';
import 'dart:async';
part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MovieDetailEmpty()) {
    on<OnMovieDetail>(_onMovieDetail);
  }

  FutureOr<void> _onMovieDetail(
      OnMovieDetail event, Emitter<MovieDetailState> emit) async {
    final id = event.id;

    emit(MovieDetailLoading());
    final result = await _getMovieDetail.execute(id);

    result.fold((failure) {
      emit(MovieDetailError(failure.message));
    }, (success) {
      emit(MovieDetailHasData(success));
    });
  }
}
