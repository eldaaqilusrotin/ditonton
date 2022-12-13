import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'tv_recommendations_bloc_test.mocks.dart';
import '../../dummy_data/tv_dummy_objects.dart';

void main() {
  late MockGetTvRecommendations mockGetRecommendationsTv;
  late TvRecommendationBloc tvRecommendationBloc;

  const testId = 1;

  setUp(() {
    mockGetRecommendationsTv = MockGetTvRecommendations();
    tvRecommendationBloc = TvRecommendationBloc(mockGetRecommendationsTv);
  });

  test("the initial state should be empty", () {
    expect(tvRecommendationBloc.state, TvRecommendationEmpty());
  });

  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetRecommendationsTv.execute(testId))
          .thenAnswer((_) async => Right(testTvList));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnTvRecommendation(testId)),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationsTv.execute(testId));
      return OnTvRecommendation(testId).props;
    },
  );

  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetRecommendationsTv.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnTvRecommendation(testId)),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationError('Server Failure'),
    ],
    verify: (bloc) => TvRecommendationLoading(),
  );

  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetRecommendationsTv.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnTvRecommendation(testId)),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationEmpty(),
    ],
  );
}
