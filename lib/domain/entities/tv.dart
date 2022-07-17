import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv({
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  String? backdropPath;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  double? voteAverage;

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        name,
        overview,
        posterPath,
        voteAverage,
      ];
}
