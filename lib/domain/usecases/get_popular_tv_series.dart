import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetPopularTvSeries {
  final TvRepository tvRepository;

  GetPopularTvSeries(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute() {
    return tvRepository.getPopularTvSeries();
  }
}
