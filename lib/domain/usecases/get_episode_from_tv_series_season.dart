import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetEpisodeFromTvSeriesSeason {
  final TvRepository repository;

  GetEpisodeFromTvSeriesSeason(this.repository);

  Future<Either<Failure, List<Episode>>> execute(
    int id,
    int seasonNumber,
  ) async {
    return repository.getEpisodeFromTvSeriesSeason(id, seasonNumber);
  }
}
