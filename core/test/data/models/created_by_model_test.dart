import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  const tCreatedByModel = CreatedByModel(
    id: 1,
    creditId: 'creditId',
    name: 'name',
    gender: 1,
    profilePath: 'profilePath',
  );

  test(
    'should have a correct data',
    () async {
      expect(tCreatedByModel, tCreatedByModel);
    },
  );
}
