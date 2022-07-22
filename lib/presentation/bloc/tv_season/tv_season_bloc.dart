import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_episode_from_tv_series_season.dart';
import 'package:equatable/equatable.dart';

part 'tv_season_event.dart';
part 'tv_season_state.dart';

class TvSeasonBloc extends Bloc<TvSeasonEvent, TvSeasonState> {
  final GetEpisodeFromTvSeriesSeason getEpisodeFromTvSeriesSeason;

  TvSeasonBloc({required this.getEpisodeFromTvSeriesSeason})
      : super(TvSeasonState.initial()) {
    on<GetSeasonEpisode>(_getSeasonEpisode);
  }

  void _getSeasonEpisode(event, emit) async {
    emit(state.copyWith(requestState: RequestState.Loading));

    final result = await getEpisodeFromTvSeriesSeason.execute(
      event.id,
      event.numberOfSeason,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          requestState: RequestState.Error,
          message: failure.message,
        ));
      },
      (episode) {
        emit(state.copyWith(
          requestState: RequestState.Loaded,
          episodes: episode,
        ));
      },
    );
  }
}
