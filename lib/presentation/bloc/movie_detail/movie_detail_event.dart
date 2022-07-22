part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMovieDetailEvent extends MovieDetailEvent {
  final int id;

  GetMovieDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class LoadWatchlistStatus extends MovieDetailEvent {
  final int id;

  LoadWatchlistStatus({required this.id});

  @override
  List<Object> get props => [id];
}

class AddWatchlistEvent extends MovieDetailEvent {
  final MovieDetail movie;

  AddWatchlistEvent({required this.movie});

  @override
  List<Object> get props => [movie];
}

class RemoveWatchlistEvent extends MovieDetailEvent {
  final MovieDetail movie;

  RemoveWatchlistEvent({required this.movie});

  @override
  List<Object> get props => [movie];
}
