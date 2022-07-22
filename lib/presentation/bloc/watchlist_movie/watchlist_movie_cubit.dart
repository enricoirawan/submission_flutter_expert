import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieCubit extends Cubit<WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieCubit({
    required this.getWatchlistMovies,
  }) : super(WatchlistMovieState.initial());

  void getWatchlistMoviesFromDB() async {
    emit(state.copyWith(requestState: RequestState.Loading));

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          message: failure.message,
          requestState: RequestState.Error,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
          requestState: RequestState.Loaded,
          movies: moviesData,
        ));
      },
    );
  }
}
