import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_state.dart';

class WatchlistTvCubit extends Cubit<WatchlistTvState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvCubit({
    required this.getWatchlistTvSeries,
  }) : super(WatchlistTvState.intial());

  void getWatchlistTvSeriesFromDB() async {
    emit(state.copyWith(requestState: RequestState.Loading));

    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          message: failure.message,
          requestState: RequestState.Error,
        ));
      },
      (tv) {
        emit(state.copyWith(
          requestState: RequestState.Loaded,
          tv: tv,
        ));
      },
    );
  }
}
