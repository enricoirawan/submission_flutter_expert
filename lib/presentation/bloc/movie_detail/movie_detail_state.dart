part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieDetail detail;
  final List<Movie> recommendations;
  final RequestState requestState;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;

  const MovieDetailState({
    required this.detail,
    required this.recommendations,
    required this.requestState,
    required this.isAddedToWatchlist,
    required this.message,
    required this.watchlistMessage,
  });

  MovieDetailState copyWith({
    MovieDetail? detail,
    List<Movie>? recommendations,
    RequestState? requestState,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return MovieDetailState(
      detail: detail ?? this.detail,
      recommendations: recommendations ?? this.recommendations,
      requestState: requestState ?? this.requestState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.message,
    );
  }

  factory MovieDetailState.initial() {
    return MovieDetailState(
      detail: MovieDetail.initial(),
      recommendations: [],
      requestState: RequestState.Empty,
      isAddedToWatchlist: false,
      message: '',
      watchlistMessage: '',
    );
  }

  @override
  List<Object> get props => [
        detail,
        recommendations,
        requestState,
        isAddedToWatchlist,
        message,
        watchlistMessage,
      ];
}
