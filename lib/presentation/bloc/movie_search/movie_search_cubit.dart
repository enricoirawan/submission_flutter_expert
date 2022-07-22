import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchCubit({
    required this.searchMovies,
  }) : super(MovieSearchState.initial());

  void search(String query) async {
    emit(state.copyWith(requestState: RequestState.Loading));

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        emit(state.copyWith(
          requestState: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(requestState: RequestState.Loaded, movies: data));
      },
    );
  }
}
