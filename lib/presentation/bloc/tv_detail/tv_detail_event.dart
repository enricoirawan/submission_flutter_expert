part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTvDetailEvent extends TvDetailEvent {
  final int id;

  GetTvDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class LoadWatchlistStatus extends TvDetailEvent {
  final int id;

  LoadWatchlistStatus({required this.id});

  @override
  List<Object> get props => [id];
}

class AddWatchlistEvent extends TvDetailEvent {
  final TvDetail tv;

  AddWatchlistEvent({required this.tv});

  @override
  List<Object> get props => [tv];
}

class RemoveWatchlistEvent extends TvDetailEvent {
  final TvDetail tv;

  RemoveWatchlistEvent({required this.tv});

  @override
  List<Object> get props => [tv];
}
