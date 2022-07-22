import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_season/tv_season_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SeasonEpisode extends StatelessWidget {
  static const ROUTE_NAME = '/season-episode';

  final int id;
  final int seasonNumber;
  const SeasonEpisode({
    Key? key,
    required this.id,
    required this.seasonNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TvSeasonBloc>()
      ..add(
        GetSeasonEpisode(
          id: id,
          numberOfSeason: seasonNumber,
        ),
      );

    return Scaffold(
      appBar: AppBar(
        title: Text("Season $seasonNumber Episodes"),
      ),
      body: BlocBuilder<TvSeasonBloc, TvSeasonState>(
        builder: (context, state) {
          if (state.requestState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.requestState == RequestState.Loaded) {
            return Container(
              child: ListView.builder(
                itemCount: state.episodes.length,
                itemBuilder: (context, index) {
                  final episode = state.episodes[index];
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Episode - ${episode.episodeNumber.toString()}",
                              style: kHeading6,
                            ),
                            Text(
                              "Title",
                              style: kHeading6,
                            ),
                            Text(
                              episode.name,
                              style: kSubtitle,
                            ),
                            Text(
                              "Overview",
                              style: kHeading6,
                            ),
                            Text(
                              episode.overview.isEmpty ? "-" : episode.overview,
                              style: kSubtitle,
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: episode.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${episode.voteAverage}')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(state.message),
            );
          }
        },
      ),
    );
  }
}
