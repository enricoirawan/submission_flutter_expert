import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv/watchlist_tv_cubit.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
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
                child: BlocBuilder<WatchlistMovieCubit, WatchlistMovieState>(
                  builder: (context, state) {
                    if (state.requestState == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.requestState == RequestState.Loaded) {
                      if (state.movies.isEmpty) {
                        return Center(
                          child: Text("Masih kosong..."),
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final movie = state.movies[index];
                          return MovieCard(
                            movie: movie,
                          );
                        },
                        itemCount: state.movies.length,
                      );
                    } else {
                      return Center(
                        key: Key('error_message'),
                        child: Text(state.message),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<WatchlistTvCubit, WatchlistTvState>(
                  builder: (context, state) {
                    if (state.requestState == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.requestState == RequestState.Loaded) {
                      if (state.tv.isEmpty) {
                        return Center(
                          child: Text("Masih kosong..."),
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final tv = state.tv[index];
                          return TvCard(
                            tv: tv,
                          );
                        },
                        itemCount: state.tv.length,
                      );
                    } else {
                      return Center(
                        key: Key('error_message'),
                        child: Text(state.message),
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
