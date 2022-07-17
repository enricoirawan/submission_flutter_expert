import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertTvToWatchlist(TvTable tv);
  Future<String> removeTvFromWatchlist(TvTable tv);
  Future<TvTable?> getTvSeriesById(int id);
  Future<List<TvTable>> getWatchlistTvSeries();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvTable?> getTvSeriesById(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertTvToWatchlist(TvTable tv) async {
    try {
      await databaseHelper.insertWatchlistTvSeries(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvFromWatchlist(TvTable tv) async {
    try {
      await databaseHelper.removeWatchlistTvSeries(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
