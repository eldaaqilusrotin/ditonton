import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';

void main() {
  const tGuestStarModel = GuestStarModel(
    id: 1,
    name: 'name',
    creditId: 'creditId',
    character: 'character',
    order: 1,
    profilePath: 'profilePath',
  );

  final tGuestStar = GuestStar(
    id: 1,
    name: 'name',
    creditId: 'creditId',
    character: 'character',
    order: 1,
    profilePath: 'profilePath',
  );

  test(
    'should be subclass of Guest Star entity',
    () async {
      final result = tGuestStarModel.toEntity();
      expect(result, tGuestStar);
    },
  );
}
