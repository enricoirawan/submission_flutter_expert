part of 'movie_search_cubit.dart';

class MovieSearchState extends Equatable {
  final List<Movie> movies;
  final RequestState requestState;
  final String message;

  const MovieSearchState({
    required this.movies,
    required this.requestState,
    required this.message,
  });

  MovieSearchState copyWith({
    List<Movie>? movies,
    RequestState? requestState,
    String? message,
  }) {
    return MovieSearchState(
      movies: movies ?? this.movies,
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
    );
  }

  factory MovieSearchState.initial() {
    return MovieSearchState(
      movies: [],
      requestState: RequestState.Empty,
      message: "",
    );
  }

  @override
  List<Object> get props => [movies, requestState, message];
}
