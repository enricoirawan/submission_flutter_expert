part of 'tv_season_bloc.dart';

class TvSeasonState extends Equatable {
  final List<Episode> episodes;
  final RequestState requestState;
  final String message;

  const TvSeasonState({
    required this.episodes,
    required this.requestState,
    required this.message,
  });

  TvSeasonState copyWith({
    List<Episode>? episodes,
    RequestState? requestState,
    String? message,
  }) {
    return TvSeasonState(
      episodes: episodes ?? this.episodes,
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
    );
  }

  factory TvSeasonState.initial() {
    return TvSeasonState(
      episodes: [],
      requestState: RequestState.Empty,
      message: "",
    );
  }

  @override
  List<Object> get props => [episodes, requestState, message];
}
