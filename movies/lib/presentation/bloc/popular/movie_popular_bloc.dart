import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

part 'movie_popular_event.dart';

part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(this._getPopularMovies) : super(MoviePopularEmpty()) {
    on<OnMoviePopular>(_onMoviePopular);
  }

  FutureOr<void> _onMoviePopular(
      OnMoviePopular event, Emitter<MoviePopularState> emit) async {
    final result = await _getPopularMovies.execute();

    result.fold((failure) {
      emit(MoviePopularError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MoviePopularEmpty())
          : emit(MoviePopularHasData(success));
    });
  }
}
