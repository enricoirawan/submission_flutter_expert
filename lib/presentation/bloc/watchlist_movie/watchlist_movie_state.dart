part of 'watchlist_movie_cubit.dart';

class WatchlistMovieState extends Equatable {
  final List<Movie> movies;
  final String message;
  final RequestState requestState;

  WatchlistMovieState({
    required this.movies,
    required this.message,
    required this.requestState,
  });

  WatchlistMovieState copyWith({
    List<Movie>? movies,
    String? message,
    RequestState? requestState,
  }) {
    return WatchlistMovieState(
      movies: movies ?? this.movies,
      message: message ?? this.message,
      requestState: requestState ?? this.requestState,
    );
  }

  factory WatchlistMovieState.initial() {
    return WatchlistMovieState(
      movies: [],
      message: "",
      requestState: RequestState.Empty,
    );
  }

  @override
  List<Object?> get props => [
        movies,
        message,
        requestState,
      ];
}
