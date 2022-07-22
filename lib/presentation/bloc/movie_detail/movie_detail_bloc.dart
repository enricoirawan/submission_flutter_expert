import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailState.initial()) {
    on<GetMovieDetailEvent>(_getMovieDetail);
    on<LoadWatchlistStatus>(_loadWatchlistStatus);
    on<AddWatchlistEvent>(_addWatchlist);
    on<RemoveWatchlistEvent>(_removeFromWatchlist);
  }

  void _getMovieDetail(event, emit) async {
    emit(state.copyWith(requestState: RequestState.Loading));
    final detailResult = await getMovieDetail.execute(event.id);
    final recommendationResult =
        await getMovieRecommendations.execute(event.id);

    detailResult.fold((failure) {
      emit(state.copyWith(
        requestState: RequestState.Error,
        message: failure.message,
      ));
    }, (movieDetail) {
      recommendationResult.fold(
        (failure) {
          emit(state.copyWith(
            requestState: RequestState.Error,
            message: failure.message,
          ));
        },
        (movies) {
          emit(state.copyWith(
            requestState: RequestState.Loaded,
            detail: movieDetail,
            recommendations: movies,
          ));
        },
      );
    });
  }

  void _loadWatchlistStatus(LoadWatchlistStatus event, emit) async {
    final result = await getWatchListStatus.execute(event.id);
    emit(state.copyWith(isAddedToWatchlist: result, watchlistMessage: ""));
  }

  void _addWatchlist(AddWatchlistEvent event, emit) async {
    final result = await saveWatchlist.execute(event.movie);

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
    final result = await removeWatchlist.execute(event.movie);

    await result.fold((failure) async {
      emit(state.copyWith(watchlistMessage: failure.message));
    }, (successMessage) async {
      emit(state.copyWith(watchlistMessage: successMessage));
    });
  }
}
