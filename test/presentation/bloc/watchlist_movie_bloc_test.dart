import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieCubit watchlistMovieCubit;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieCubit = WatchlistMovieCubit(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  blocTest<WatchlistMovieCubit, WatchlistMovieState>(
    "should change movies data when data is gotten successfully",
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return watchlistMovieCubit;
    },
    act: (WatchlistMovieCubit cubit) => cubit.getWatchlistMoviesFromDB(),
    expect: () => [
      WatchlistMovieState(
        requestState: RequestState.Loading,
        movies: [],
        message: "",
      ),
      WatchlistMovieState(
        requestState: RequestState.Loaded,
        movies: [testWatchlistMovie],
        message: "",
      ),
    ],
  );

  blocTest<WatchlistMovieCubit, WatchlistMovieState>(
    "should return error when data is unsuccessful",
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return watchlistMovieCubit;
    },
    act: (WatchlistMovieCubit cubit) => cubit.getWatchlistMoviesFromDB(),
    expect: () => [
      WatchlistMovieState(
        requestState: RequestState.Loading,
        movies: [],
        message: "",
      ),
      WatchlistMovieState(
        requestState: RequestState.Error,
        movies: [],
        message: "Can't get data",
      ),
    ],
  );
}
