part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  final RequestState requestState;
  final List<Movie> popularMovies;
  final List<Movie> nowPlayingMovies;
  final List<Movie> topRatedMovies;
  final String message;

  const MoviesState({
    required this.requestState,
    required this.popularMovies,
    required this.nowPlayingMovies,
    required this.topRatedMovies,
    required this.message,
  });

  factory MoviesState.initial() {
    return MoviesState(
      requestState: RequestState.Empty,
      nowPlayingMovies: [],
      popularMovies: [],
      topRatedMovies: [],
      message: '',
    );
  }

  MoviesState copyWith({
    RequestState? requestState,
    List<Movie>? popularMovies,
    List<Movie>? nowPlayingMovies,
    List<Movie>? topRatedMovies,
    String? message,
  }) {
    return MoviesState(
      requestState: requestState ?? this.requestState,
      popularMovies: popularMovies ?? this.popularMovies,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        requestState,
        nowPlayingMovies,
        popularMovies,
        topRatedMovies,
        message,
      ];
}
