import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_search_state.dart';

class TvSearchCubit extends Cubit<TvSearchState> {
  final SearchTvSeries searchTvSeries;

  TvSearchCubit({
    required this.searchTvSeries,
  }) : super(TvSearchState.initial());

  void search(String query) async {
    emit(state.copyWith(requestState: RequestState.Loading));

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        emit(state.copyWith(
          requestState: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(requestState: RequestState.Loaded, tv: data));
      },
    );
  }
}
