import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getPopularTvSeries();
  Future<Either<Failure, List<Tv>>> getNowPlayingTvSeries();
  Future<Either<Failure, List<Tv>>> getTopRatedTvSeries();
  Future<Either<Failure, TvDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, String>> saveWatchlist(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TvDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTvSeries();
  Future<Either<Failure, List<Tv>>> searchTvSeries(String query);
  Future<Either<Failure, List<Episode>>> getEpisodeFromTvSeriesSeason(
    int id,
    int seasonNumber,
  );
}
