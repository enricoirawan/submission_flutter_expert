part of 'tv_season_bloc.dart';

abstract class TvSeasonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSeasonEpisode extends TvSeasonEvent {
  final int id;
  final int numberOfSeason;

  GetSeasonEpisode({required this.id, required this.numberOfSeason});

  @override
  List<Object> get props => [id, numberOfSeason];
}
