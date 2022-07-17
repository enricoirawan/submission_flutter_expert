import 'package:equatable/equatable.dart';

import 'package:ditonton/data/models/tv_model.dart';

class TvResponse extends Equatable {
  final List<TvModel> tvLists;

  TvResponse({
    required this.tvLists,
  });

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        tvLists:
            List<TvModel>.from(json["results"].map((x) => TvModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvLists.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [tvLists];
}
