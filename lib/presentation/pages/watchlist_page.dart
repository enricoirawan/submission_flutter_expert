import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies(),
    );
    Future.microtask(
      () => Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
          .fetchWatchlistTvSeries(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Watchlist'),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.movie)),
                Tab(icon: Icon(Icons.tv)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<WatchlistMovieNotifier>(
                  builder: (context, data, child) {
                    if (data.watchlistState == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (data.watchlistState == RequestState.Loaded) {
                      if (data.watchlistMovies.isEmpty) {
                        return Center(
                          child: Text("Masih kosong..."),
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final movie = data.watchlistMovies[index];
                          return MovieCard(
                            movie: movie,
                          );
                        },
                        itemCount: data.watchlistMovies.length,
                      );
                    } else {
                      return Center(
                        key: Key('error_message'),
                        child: Text(data.message),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<WatchlistTvSeriesNotifier>(
                  builder: (context, data, child) {
                    if (data.watchlistTvState == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (data.watchlistTvState == RequestState.Loaded) {
                      if (data.watchlistTvSeries.isEmpty) {
                        return Center(
                          child: Text("Masih kosong..."),
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final tv = data.watchlistTvSeries[index];
                          return TvCard(
                            tv: tv,
                          );
                        },
                        itemCount: data.watchlistTvSeries.length,
                      );
                    } else {
                      return Center(
                        key: Key('error_message'),
                        child: Text(data.message),
                      );
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
