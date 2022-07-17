import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvSeriesWatchListStatus {
  final TvRepository repository;

  GetTvSeriesWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
