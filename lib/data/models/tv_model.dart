import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  TvModel({
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  final String? backdropPath;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final double voteAverage;

  factory TvModel.fromJson(Map<String, dynamic> json) {
    return TvModel(
      backdropPath: json["backdrop_path"] == null ? "" : json["backdrop_path"],
      id: json["id"],
      name: json["name"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      voteAverage: json["vote_average"].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "vote_average": voteAverage,
      };

  Tv toEntity() {
    return Tv(
      backdropPath: this.backdropPath,
      id: this.id,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      // seasons: this.seasons,
    );
  }

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
