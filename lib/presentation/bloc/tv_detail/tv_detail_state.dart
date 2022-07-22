part of 'tv_detail_bloc.dart';

class TvDetailState extends Equatable {
  final TvDetail detail;
  final List<Tv> recommendations;
  final RequestState requestState;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;

  const TvDetailState({
    required this.detail,
    required this.recommendations,
    required this.requestState,
    required this.isAddedToWatchlist,
    required this.message,
    required this.watchlistMessage,
  });

  TvDetailState copyWith({
    TvDetail? detail,
    List<Tv>? recommendations,
    RequestState? requestState,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return TvDetailState(
      detail: detail ?? this.detail,
      recommendations: recommendations ?? this.recommendations,
      requestState: requestState ?? this.requestState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  factory TvDetailState.initial() {
    return TvDetailState(
      detail: TvDetail.initial(),
      recommendations: [],
      requestState: RequestState.Empty,
      isAddedToWatchlist: false,
      message: "",
      watchlistMessage: "",
    );
  }

  @override
  List<Object> get props {
    return [
      detail,
      recommendations,
      requestState,
      isAddedToWatchlist,
      message,
      watchlistMessage,
    ];
  }
}
