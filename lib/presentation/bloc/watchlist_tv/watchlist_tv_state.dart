part of 'watchlist_tv_cubit.dart';

class WatchlistTvState extends Equatable {
  final List<Tv> tv;
  final String message;
  final RequestState requestState;

  const WatchlistTvState({
    required this.tv,
    required this.message,
    required this.requestState,
  });

  WatchlistTvState copyWith({
    List<Tv>? tv,
    String? message,
    RequestState? requestState,
  }) {
    return WatchlistTvState(
      tv: tv ?? this.tv,
      message: message ?? this.message,
      requestState: requestState ?? this.requestState,
    );
  }

  factory WatchlistTvState.intial() {
    return WatchlistTvState(
      message: "",
      tv: [],
      requestState: RequestState.Empty,
    );
  }

  @override
  List<Object> get props => [
        tv,
        message,
        requestState,
      ];
}
