import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';


class FakeMovieState extends Fake implements MovieDetailState {}

class FakeMovieEvent extends Fake implements MovieDetailState {}

class MockNowPlayingMoviesBloc extends MockBloc<MovieNowPlayingEvent, MovieNowPlayingState>
    implements MovieNowPlayingBloc {}

class MockPopularMoviesBloc extends MockBloc<MoviePopularEvent, MoviePopularState>
    implements MoviePopularBloc {}

class MockTopRatedMoviesBloc extends MockBloc<MovieTopRatedEvent, MovieTopRatedState>
    implements MovieTopRatedBloc {}

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MockMovieRecommendationsBloc extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

class MockMovieWatchlistBloc extends MockBloc<MovieWatchListEvent, MovieWatchListState>
    implements MovieWatchListBloc {}
