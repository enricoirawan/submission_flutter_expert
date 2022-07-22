part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPopularMoviesEvent extends MoviesEvent {
  @override
  List<Object> get props => [];
}

class GetNowPlayingMoviesEvent extends MoviesEvent {
  @override
  List<Object> get props => [];
}

class GetTopRatedMoviesEvent extends MoviesEvent {
  @override
  List<Object> get props => [];
}
