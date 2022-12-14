import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/tv_dummy_objects.dart';
import '../helpers/tv_test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('test failure', () {
    test('server failure', () async {
      when(mockRemoteDataSource.getNowPlayingTv()).thenThrow(ServerException());

      final result = await repository.getNowPlayingTv();

      verify(mockRemoteDataSource.getNowPlayingTv());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test('connection failure', () async {
      when(mockRemoteDataSource.getNowPlayingTv())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getNowPlayingTv();

      verify(mockRemoteDataSource.getNowPlayingTv());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

    test('database failure', () async {
      when(mockLocalDataSource.insertTvWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      final result = await repository.saveWatchlist(testTvDetail);

      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });
}
