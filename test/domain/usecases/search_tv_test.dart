import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvRepository();
    usecase = SearchTvSeries(mockTvRpository);
  });

  final tTv = <Tv>[];
  final tQuery = "minion";

  group('SearchTv Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRpository.searchTvSeries(tQuery))
            .thenAnswer((_) async => Right(tTv));
        // act
        final result = await usecase.execute(tQuery);
        // assert
        expect(result, Right(tTv));
      });
    });
  });
}
