import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/now_playing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/presentation/widgets/item_banner.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series';

  const TvSeriesPage({Key? key}) : super(key: key);

  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TvListNotifier>(context, listen: false)
        ..fetchPopularTvSeries()
        ..fetchNowPlayingTvSeries()
        ..fetchTopRatedTvSeries(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchPage.ROUTE_NAME,
                arguments: false,
              );
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubHeading(
                title: 'Now Playing',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    NowPlayingTvSeriesPage.ROUTE_NAME,
                  );
                },
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingTvState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return ItemBanner(
                    list: data.nowPlayingTv,
                    onTap: (id) {
                      Navigator.pushNamed(
                        context,
                        TvSeriesDetailPage.ROUTE_NAME,
                        arguments: id,
                      );
                    },
                  );
                } else {
                  return Text('Failed');
                }
              }),
              SubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME);
                },
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.popularTvState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return ItemBanner(
                    list: data.popularTv,
                    onTap: (id) {
                      Navigator.pushNamed(
                        context,
                        TvSeriesDetailPage.ROUTE_NAME,
                        arguments: id,
                      );
                    },
                  );
                } else {
                  return Text('Failed');
                }
              }),
              SubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME);
                },
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.topRatedtvState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return ItemBanner(
                    list: data.topRatedtv,
                    onTap: (id) {
                      Navigator.pushNamed(
                        context,
                        TvSeriesDetailPage.ROUTE_NAME,
                        arguments: id,
                      );
                    },
                  );
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
