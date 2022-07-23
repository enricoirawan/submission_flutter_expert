import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      removeWatchlist: mockRemoveWatchlist,
      saveWatchlist: mockSaveWatchlist,
    );
  });

  final tId = 1;
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
  final tMovies = <Movie>[tMovie];

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      "should change state to Loading when usecase is called",
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(GetMovieDetailEvent(id: tId)),
      expect: () => [
        MovieDetailState(
          detail: MovieDetail.initial(),
          recommendations: [],
          requestState: RequestState.Loading,
          isAddedToWatchlist: false,
          message: "",
          watchlistMessage: "",
        ),
        MovieDetailState(
          detail: testMovieDetail,
          recommendations: tMovies,
          requestState: RequestState.Loaded,
          isAddedToWatchlist: false,
          message: "",
          watchlistMessage: "",
        )
      ],
    );
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    "should change state to error when data is failed",
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovies));
      return movieDetailBloc;
    },
    act: (MovieDetailBloc bloc) => bloc.add(GetMovieDetailEvent(id: tId)),
    expect: () => [
      MovieDetailState(
        detail: MovieDetail.initial(),
        recommendations: [],
        requestState: RequestState.Loading,
        isAddedToWatchlist: false,
        message: "",
        watchlistMessage: "",
      ),
      MovieDetailState(
        detail: MovieDetail.initial(),
        recommendations: [],
        requestState: RequestState.Error,
        isAddedToWatchlist: false,
        message: "Server Failure",
        watchlistMessage: "",
      )
    ],
  );

  group('Watchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      "should get the watchlist status",
      build: () {
        when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(LoadWatchlistStatus(id: tId)),
      expect: () => [
        MovieDetailState(
          detail: MovieDetail.initial(),
          recommendations: [],
          requestState: RequestState.Empty,
          isAddedToWatchlist: true,
          message: "",
          watchlistMessage: "",
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "should update watchlist message when add watchlist success",
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) =>
          bloc.add(AddWatchlistEvent(movie: testMovieDetail)),
      expect: () => [
        MovieDetailState(
          detail: MovieDetail.initial(),
          recommendations: [],
          requestState: RequestState.Empty,
          isAddedToWatchlist: false,
          message: "",
          watchlistMessage: "Added to Watchlist",
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "should update watchlist message when add watchlist failed",
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) =>
          bloc.add(AddWatchlistEvent(movie: testMovieDetail)),
      expect: () => [
        MovieDetailState(
          detail: MovieDetail.initial(),
          recommendations: [],
          requestState: RequestState.Empty,
          isAddedToWatchlist: false,
          message: "",
          watchlistMessage: "Failed",
        ),
      ],
    );
  });

  tearDown(() {
    movieDetailBloc.close();
  });
}
