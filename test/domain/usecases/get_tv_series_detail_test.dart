import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvRepository();
    usecase = GetTvSeriesDetail(mockTvRpository);
  });

  final tId = 1;

  group('GetTvDetail Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRpository.getTvSeriesDetail(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(testTvSeriesDetail));
      });
    });
  });
}
