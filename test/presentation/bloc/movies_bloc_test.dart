import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movies/movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movies_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MoviesBloc moviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    moviesBloc = MoviesBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group('Movies Bloc', () {
    blocTest<MoviesBloc, MoviesState>(
      "Verify initial state",
      build: () => moviesBloc,
      expect: () => [],
    );

    blocTest<MoviesBloc, MoviesState>(
      "Emits [requestState.loading and requestState.loaded] when getNowPlayingMovies is call",
      build: () {
        when(
          mockGetNowPlayingMovies.execute(),
        ).thenAnswer((_) async => Right(tMovieList));
        return moviesBloc;
      },
      act: (MoviesBloc bloc) => bloc.add(GetNowPlayingMoviesEvent()),
      expect: () => [
        MoviesState(
          requestState: RequestState.Loading,
          popularMovies: [],
          nowPlayingMovies: [],
          topRatedMovies: [],
          message: "",
        ),
        MoviesState(
          requestState: RequestState.Loaded,
          popularMovies: [],
          nowPlayingMovies: tMovieList,
          topRatedMovies: [],
          message: "",
        )
      ],
    );

    blocTest<MoviesBloc, MoviesState>(
      "Emits [requestState.loading and requestState.loaded] when getPopularMovies is call",
      build: () {
        when(
          mockGetPopularMovies.execute(),
        ).thenAnswer((_) async => Right(tMovieList));
        return moviesBloc;
      },
      act: (MoviesBloc bloc) => bloc.add(GetPopularMoviesEvent()),
      expect: () => [
        MoviesState(
          requestState: RequestState.Loading,
          popularMovies: [],
          nowPlayingMovies: [],
          topRatedMovies: [],
          message: "",
        ),
        MoviesState(
          requestState: RequestState.Loaded,
          popularMovies: tMovieList,
          nowPlayingMovies: [],
          topRatedMovies: [],
          message: "",
        )
      ],
    );

    blocTest<MoviesBloc, MoviesState>(
      "Emits [requestState.loading and requestState.loaded] when getTopRatedMovies is call",
      build: () {
        when(
          mockGetTopRatedMovies.execute(),
        ).thenAnswer((_) async => Right(tMovieList));
        return moviesBloc;
      },
      act: (MoviesBloc bloc) => bloc.add(GetTopRatedMoviesEvent()),
      expect: () => [
        MoviesState(
          requestState: RequestState.Loading,
          popularMovies: [],
          nowPlayingMovies: [],
          topRatedMovies: [],
          message: "",
        ),
        MoviesState(
          requestState: RequestState.Loaded,
          popularMovies: [],
          nowPlayingMovies: [],
          topRatedMovies: tMovieList,
          message: "",
        )
      ],
    );

    blocTest<MoviesBloc, MoviesState>(
      "Emits [requestState.error and message] when data is unsuccessful",
      build: () {
        when(
          mockGetTopRatedMovies.execute(),
        ).thenAnswer((_) async => Left(ServerFailure("server failure")));
        return moviesBloc;
      },
      act: (MoviesBloc bloc) => bloc.add(GetTopRatedMoviesEvent()),
      expect: () => [
        MoviesState(
          requestState: RequestState.Loading,
          popularMovies: [],
          nowPlayingMovies: [],
          topRatedMovies: [],
          message: "",
        ),
        MoviesState(
          requestState: RequestState.Error,
          popularMovies: [],
          nowPlayingMovies: [],
          topRatedMovies: [],
          message: "server failure",
        )
      ],
    );
  });

  tearDown(() {
    moviesBloc.close();
  });
}
