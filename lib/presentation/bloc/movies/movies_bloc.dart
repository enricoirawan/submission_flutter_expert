import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MoviesBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MoviesState.initial()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);
    on<GetPopularMoviesEvent>(_getPopularMovies);
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
  }

  void _getPopularMovies(event, emit) async {
    emit(state.copyWith(requestState: RequestState.Loading));

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          requestState: RequestState.Error,
          message: failure.message,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
          requestState: RequestState.Loaded,
          popularMovies: moviesData,
        ));
      },
    );
  }

  void _getNowPlayingMovies(event, emit) async {
    emit(state.copyWith(requestState: RequestState.Loading));

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          requestState: RequestState.Error,
          message: failure.message,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
          requestState: RequestState.Loaded,
          nowPlayingMovies: moviesData,
        ));
      },
    );
  }

  void _getTopRatedMovies(event, emit) async {
    emit(state.copyWith(requestState: RequestState.Loading));

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          requestState: RequestState.Error,
          message: failure.message,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
          requestState: RequestState.Loaded,
          topRatedMovies: moviesData,
        ));
      },
    );
  }
}
