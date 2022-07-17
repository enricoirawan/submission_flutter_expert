import 'package:ditonton/data/models/episode_model.dart';
import 'package:equatable/equatable.dart';

class SeasonResponse extends Equatable {
  final List<EpisodeModel> episodes;

  SeasonResponse({
    required this.episodes,
  });

  factory SeasonResponse.fromJson(Map<String, dynamic> json) => SeasonResponse(
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [episodes];
}
