import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvSeriesWatchListStatus getTvSeriesWatchListStatus;
  final SaveTvSeriesWatchlist saveTvSeriesWatchlist;
  final RemoveTvSeriesWatchlist removeTvSeriesWatchlist;
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvDetailBloc({
    required this.getTvSeriesWatchListStatus,
    required this.saveTvSeriesWatchlist,
    required this.removeTvSeriesWatchlist,
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
  }) : super(TvDetailState.initial()) {
    on<GetTvDetailEvent>(_getTvDetail);
    on<LoadWatchlistStatus>(_loadWatchlistStatus);
    on<AddWatchlistEvent>(_addWatchlist);
    on<RemoveWatchlistEvent>(_removeFromWatchlist);
  }

  void _getTvDetail(event, emit) async {
    emit(state.copyWith(requestState: RequestState.Loading));
    final detailResult = await getTvSeriesDetail.execute(event.id);
    final recommendationResult =
        await getTvSeriesRecommendations.execute(event.id);

    detailResult.fold((failure) {
      emit(state.copyWith(
        requestState: RequestState.Error,
        message: failure.message,
      ));
    }, (tvDetail) {
      recommendationResult.fold(
        (failure) {
          emit(state.copyWith(
            requestState: RequestState.Error,
            message: failure.message,
          ));
        },
        (tvList) {
          emit(state.copyWith(
            requestState: RequestState.Loaded,
            detail: tvDetail,
            recommendations: tvList,
          ));
        },
      );
    });
  }

  void _loadWatchlistStatus(LoadWatchlistStatus event, emit) async {
    final result = await getTvSeriesWatchListStatus.execute(event.id);
    emit(state.copyWith(isAddedToWatchlist: result, watchlistMessage: ""));
  }

  void _addWatchlist(AddWatchlistEvent event, emit) async {
    final result = await saveTvSeriesWatchlist.execute(event.tv);

    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) async {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );
  }

  void _removeFromWatchlist(RemoveWatchlistEvent event, emit) async {
    final result = await removeTvSeriesWatchlist.execute(event.tv);

    await result.fold((failure) async {
      emit(state.copyWith(watchlistMessage: failure.message));
    }, (successMessage) async {
      emit(state.copyWith(watchlistMessage: successMessage));
    });
  }
}
