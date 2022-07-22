part of 'tv_list_bloc.dart';

class TvListState extends Equatable {
  final RequestState requestState;
  final List<Tv> popularTv;
  final List<Tv> nowPlayingTv;
  final List<Tv> topRatedTv;
  final String message;
  TvListState({
    required this.requestState,
    required this.popularTv,
    required this.nowPlayingTv,
    required this.topRatedTv,
    required this.message,
  });

  TvListState copyWith({
    RequestState? requestState,
    List<Tv>? popularTv,
    List<Tv>? nowPlayingTv,
    List<Tv>? topRatedTv,
    String? message,
  }) {
    return TvListState(
      requestState: requestState ?? this.requestState,
      popularTv: popularTv ?? this.popularTv,
      nowPlayingTv: nowPlayingTv ?? this.nowPlayingTv,
      topRatedTv: topRatedTv ?? this.topRatedTv,
      message: message ?? this.message,
    );
  }

  factory TvListState.initial() {
    return TvListState(
      requestState: RequestState.Empty,
      popularTv: [],
      nowPlayingTv: [],
      topRatedTv: [],
      message: '',
    );
  }

  @override
  List<Object> get props {
    return [
      requestState,
      popularTv,
      nowPlayingTv,
      topRatedTv,
      message,
    ];
  }
}
