import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_cubit.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_cubit.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  final bool searchMovie;

  SearchPage({
    required this.searchMovie,
  });

  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                if (searchMovie) {
                  context.read<MovieSearchCubit>().search(query);
                } else {
                  context.read<TvSearchCubit>().search(query);
                }
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            searchMovie
                ? BlocBuilder<MovieSearchCubit, MovieSearchState>(
                    builder: (context, state) {
                    if (state.requestState == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.requestState == RequestState.Loaded) {
                      final result = state.movies;
                      if (result.isEmpty) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text("Hasil pencarian kosong"),
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final movie = state.movies[index];
                            return MovieCard(
                              movie: movie,
                            );
                          },
                          itemCount: result.length,
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Container(),
                      );
                    }
                  })
                : BlocBuilder<TvSearchCubit, TvSearchState>(
                    builder: (context, state) {
                    if (state.requestState == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.requestState == RequestState.Loaded) {
                      final result = state.tv;
                      if (result.isEmpty) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text("Hasil pencarian kosong"),
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final tv = state.tv[index];
                            return TvCard(
                              tv: tv,
                            );
                          },
                          itemCount: result.length,
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Container(),
                      );
                    }
                  })
          ],
        ),
      ),
    );
  }
}
