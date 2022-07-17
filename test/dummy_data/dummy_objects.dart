import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvSeries = Tv(
  backdropPath: "/muth4OYamXf41G2evdrLEg8d3om.jpg",
  id: 76479,
  name: "The Boys",
  overview:
      "A group of vigilantes known informally as “The Boys” set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.",
  posterPath: "/stTEycfG9928HYGEISBFaG1ngjM.jpg",
  voteAverage: 8.5,
);

final testListTvSeries = [testTvSeries];

final testTvSeriesDetail = TvDetail(
  adult: false,
  backdropPath: "/56v2KjBlU4XaOv9rVYEQypROD7P.jpg",
  genres: [Genre(id: 1, name: 'Action')],
  id: 66732,
  name: "Stranger Things",
  numberOfEpisodes: 34,
  numberOfSeasons: 4,
  originalName: "",
  overview: "Stranger Things",
  popularity: 4235.257,
  posterPath: "/49WJfeN0moxb9IPfGn8AIqMGskD.jpg",
  status: "Returning Series",
  tagline: "Every ending has a beginning.",
  voteAverage: 8.6,
  seasons: [
    Season(
      episodeCount: 8,
      id: 77680,
      name: "Season 1",
      overview:
          "Strange things are afoot in Hawkins, Indiana, where a young boy's sudden disappearance unearths a young girl with otherworldly powers.",
      posterPath: "/rbnuP7hlynAMLdqcQRCpZW9qDkV.jpg",
      seasonNumber: 1,
    )
  ],
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'name',
};

final EpisodeModel testEpisode = EpisodeModel(
  episodeNumber: 1,
  id: 1130462,
  name: "Bond of Love and Youth",
  overview: "",
  voteAverage: 8.8,
);

final testListEpisode = [testEpisode];
