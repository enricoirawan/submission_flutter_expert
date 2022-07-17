import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_episode_from_tv_series_season.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetEpisodeFromTvSeriesSeason usecase;
  late MockTvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvRepository();
    usecase = GetEpisodeFromTvSeriesSeason(mockTvRpository);
  });

  final tEpisode = <Episode>[];
  final tId = 1;
  final tSeasonNumber = 1;

  group('GetNowPlaying Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRpository.getEpisodeFromTvSeriesSeason(tId, tSeasonNumber))
            .thenAnswer((_) async => Right(tEpisode));
        // act
        final result = await usecase.execute(tId, tSeasonNumber);
        // assert
        expect(result, Right(tEpisode));
      });
    });
  });
}
