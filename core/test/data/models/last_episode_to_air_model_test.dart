import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';

void main() {
  const tLastEpisodeToAirModel = LastEpisodeToAirModel(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tLastEpisodeToAir = LastEpisodeToAir(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    seasonNumber: 1,
    voteAverage: 1,
    voteCount: 1,
  );

  test(
    'should be a subclass of Last Episode To Air entity',
    () async {
      final result = tLastEpisodeToAirModel.toEntity();
      expect(result, tLastEpisodeToAir);
    },
  );
}
