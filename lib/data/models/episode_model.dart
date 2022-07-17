import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  EpisodeModel({
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
  });

  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final double voteAverage;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "vote_average": voteAverage,
      };

  Episode toEntity() => Episode(
        episodeNumber: episodeNumber,
        id: id,
        name: name,
        overview: overview,
        voteAverage: voteAverage,
      );

  @override
  List<Object?> get props => [
        episodeNumber,
        id,
        name,
        overview,
        voteAverage,
      ];
}
