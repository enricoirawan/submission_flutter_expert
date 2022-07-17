import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvSeriesWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveTvSeriesWatchlist(mockTvRepository);
  });

  test('should remove tv from the repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvRepository.removeWatchlist(testTvSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
