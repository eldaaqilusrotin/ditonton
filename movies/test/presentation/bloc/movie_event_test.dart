import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/movie_dummy_objects.dart';

void main() {
  test(
    'test movie event',
    () async {
      expect(OnMovieNowPLayingCalled(), OnMovieNowPLayingCalled());
      expect(OnMoviePopular(), OnMoviePopular());
      expect(OnMovieTopRated(),OnMovieTopRated());
      expect(OnMovieRecommendation(1),
          OnMovieRecommendation(testMovieDetail.id));
      expect(OnMovieDetail(1), OnMovieDetail(testMovieDetail.id));
      expect(OnFetchMovieWatchList(), OnFetchMovieWatchList());
      expect(MovieWatchListStatus(1),
          MovieWatchListStatus(testMovieDetail.id));
      expect(MovieWatchListAdd(testMovieDetail),
      MovieWatchListAdd(testMovieDetail));
      expect(MovieWatchListRemove(testMovieDetail),
          MovieWatchListRemove(testMovieDetail));
    },
  );
}
