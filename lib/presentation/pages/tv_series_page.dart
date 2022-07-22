import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:ditonton/presentation/pages/now_playing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/widgets/item_banner.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/tv-series';

  const TvSeriesPage({Key? key}) : super(key: key);

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
              BlocBuilder<TvListBloc, TvListState>(
                builder: (context, state) {
                  if (state.requestState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.requestState == RequestState.Loaded) {
                    return ItemBanner(
                      list: state.nowPlayingTv,
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
                },
              ),
              SubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<TvListBloc, TvListState>(
                builder: (context, state) {
                  if (state.requestState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.requestState == RequestState.Loaded) {
                    return ItemBanner(
                        list: state.popularTv,
                        onTap: (id) {
                          Navigator.pushNamed(
                            context,
                            TvSeriesDetailPage.ROUTE_NAME,
                            arguments: id,
                          );
                        });
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              SubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<TvListBloc, TvListState>(
                builder: (context, state) {
                  if (state.requestState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.requestState == RequestState.Loaded) {
                    return ItemBanner(
                        list: state.topRatedTv,
                        onTap: (id) {
                          Navigator.pushNamed(
                            context,
                            TvSeriesDetailPage.ROUTE_NAME,
                            arguments: id,
                          );
                        });
                  } else {
                    return Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
