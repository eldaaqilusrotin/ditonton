
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

part 'movie_now_playing_state.dart';

part 'movie_now_playing_event.dart';

class MovieNowPlayingBloc extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState>{
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(this._getNowPlayingMovies) : super(MovieNowPlayingEmpty()) {
    on<OnMovieNowPLayingCalled>((event, emit) async {
      emit(MovieNowPlayingLoading());

      final getNowPlayingMoviesResult = await _getNowPlayingMovies.execute();

      getNowPlayingMoviesResult.fold(
            (failure) => emit(
              MovieNowPlayingError(failure.message),),
            (moviesData) => emit(
              MovieNowPlayingHasData(moviesData),
        ),
      );
    });
  }
}
