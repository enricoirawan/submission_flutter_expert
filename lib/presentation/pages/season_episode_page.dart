import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/season_episode_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class SeasonEpisode extends StatefulWidget {
  static const ROUTE_NAME = '/season-episode';

  final int id;
  final int seasonNumber;
  const SeasonEpisode({
    Key? key,
    required this.id,
    required this.seasonNumber,
  }) : super(key: key);

  @override
  State<SeasonEpisode> createState() => _SeasonEpisodeState();
}

class _SeasonEpisodeState extends State<SeasonEpisode> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<SeasonEpisodeNotifier>(context, listen: false)
          .fetchEpisodeFromTvSeriesSeason(widget.id, widget.seasonNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Season ${widget.seasonNumber} Episodes"),
      ),
      body: Consumer<SeasonEpisodeNotifier>(
        builder: (context, data, child) {
          if (data.state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.state == RequestState.Loaded) {
            return Container(
              child: ListView.builder(
                itemCount: data.episode.length,
                itemBuilder: (context, index) {
                  final episode = data.episode[index];
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
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
