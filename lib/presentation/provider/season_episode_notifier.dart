import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_episode_from_tv_series_season.dart';
import 'package:flutter/material.dart';

class SeasonEpisodeNotifier extends ChangeNotifier {
  var _episode = <Episode>[];
  List<Episode> get episode => _episode;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  SeasonEpisodeNotifier({
    required this.getEpisodeFromTvSeriesSeason,
  });

  final GetEpisodeFromTvSeriesSeason getEpisodeFromTvSeriesSeason;

  Future<void> fetchEpisodeFromTvSeriesSeason(int id, int seasonNumber) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getEpisodeFromTvSeriesSeason.execute(id, seasonNumber);
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (episodes) {
        _state = RequestState.Loaded;
        _episode = episodes;
        notifyListeners();
      },
    );
  }
}
