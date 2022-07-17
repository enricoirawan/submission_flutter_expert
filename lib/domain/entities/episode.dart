import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  Episode({
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

  @override
  List<Object?> get props => [
        episodeNumber,
        id,
        name,
        overview,
        voteAverage,
      ];
}
