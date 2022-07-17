import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvRepository();
    usecase = GetTvSeriesRecommendations(mockTvRpository);
  });

  final tTv = <Tv>[];
  final tId = 1;

  group('GetTvRecommendations Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRpository.getTvSeriesRecommendations(tId))
            .thenAnswer((_) async => Right(tTv));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(tTv));
      });
    });
  });
}
