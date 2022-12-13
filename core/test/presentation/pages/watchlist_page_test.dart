import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/movie_dummy_objects.dart';
import '../../helpers/movie_bloc_test_helper.dart';


void main() {
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  setUp(
    () {
      mockMovieWatchlistBloc = MockMovieWatchlistBloc();
      registerFallbackValue(FakeMovieEvent());
      registerFallbackValue(FakeMovieState());
    },
  );

  testWidgets(
    'Page should display watchlist',
    (widgetTester) async {
      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieWatchListHasData(testMovieList));

      final movieIconFinder = find.byIcon(Icons.movie);
      final pageFinder = find.byType(WatchlistMoviesPage);

      await widgetTester.pumpWidget(
        BlocProvider<MovieWatchListBloc>.value(
          value: mockMovieWatchlistBloc,
          child: MaterialApp(
            home: const WatchListPage(),
            theme: ThemeData.dark().copyWith(
              textTheme: textTheme,
            ),
          ),
        ),
      );

      expect(movieIconFinder, findsOneWidget);

      expect(pageFinder, findsOneWidget);
    },
  );
}
