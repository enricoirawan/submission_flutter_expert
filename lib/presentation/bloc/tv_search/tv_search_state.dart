part of 'tv_search_cubit.dart';

class TvSearchState extends Equatable {
  final List<Tv> tv;
  final RequestState requestState;
  final String message;

  const TvSearchState({
    required this.tv,
    required this.requestState,
    required this.message,
  });

  TvSearchState copyWith({
    List<Tv>? tv,
    RequestState? requestState,
    String? message,
  }) {
    return TvSearchState(
      tv: tv ?? this.tv,
      requestState: requestState ?? this.requestState,
      message: message ?? this.message,
    );
  }

  factory TvSearchState.initial() {
    return TvSearchState(
      tv: [],
      requestState: RequestState.Empty,
      message: "",
    );
  }

  @override
  List<Object> get props => [tv, requestState, message];
}
