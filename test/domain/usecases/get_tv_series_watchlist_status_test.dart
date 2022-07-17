import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesWatchListStatus usecase;
  late MockTvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvRepository();
    usecase = GetTvSeriesWatchListStatus(mockTvRpository);
  });

  final tId = 1;

  group('GetTvDetail Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRpository.isAddedToWatchlist(tId))
            .thenAnswer((_) async => true);
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, true);
      });
    });
  });
}
