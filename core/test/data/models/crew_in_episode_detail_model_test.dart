import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
void main() {
  const tCrewInEpisodeDetailModel = CrewInEpisodeDetailModel(
    id: 1,
    creditId: 'creditId',
    name: 'name',
    department: 'department',
    job: 'job',
    profilePath: 'profilePath',
  );

  final tCrewInEpisodeDetail = CrewInEpisodeDetail(
    id: 1,
    creditId: 'creditId',
    name: 'name',
    department: 'department',
    job: 'job',
    profilePath: 'profilePath',
  );

  test(
    'should be a subclass of Crew In Episode Detail entity',
    () async {
      final result = tCrewInEpisodeDetailModel.toEntity();
      expect(result, tCrewInEpisodeDetail);
    },
  );
}
