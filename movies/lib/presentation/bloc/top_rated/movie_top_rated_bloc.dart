import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

part 'movie_top_rated_state.dart';

part 'movie_top_rated_event.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(this._getTopRatedMovies) : super(MovieTopRatedEmpty()) {
    on<OnMovieTopRated>(_onMovieTopRated);
  }

  FutureOr<void> _onMovieTopRated(
      OnMovieTopRated event, Emitter<MovieTopRatedState> emit) async {
    emit(MovieTopRatedLoading());

    final result = await _getTopRatedMovies.execute();

    result.fold((failure) {
      emit(MovieTopRatedError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MovieTopRatedEmpty())
          : emit(MovieTopRatedHasData(success));
    });
  }
}
