part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  const TvState();

  @override
  List<Object> get props => [];
}

class TvEmpty extends TvState {}

class TvLoading extends TvState {}

class TvError extends TvState {
  final String message;

  const TvError(this.message);

  @override
  List<Object> get props => [message];
}

class TvListHasData extends TvState {
  final List<Tv> result;

  const TvListHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvDetailHasData extends TvState {
  final TvDetail result;

  const TvDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvSeasonDetailHasData extends TvState {
  final TvSeasonDetail result;

  const TvSeasonDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvEpisodeDetailHasData extends TvState {
  final TvEpisodeDetail result;

  const TvEpisodeDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvWatchlistMessage extends TvState {
  final String message;

  const TvWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}


abstract class TvWatchListState extends Equatable {}

class TvWatchListInitial extends TvWatchListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvWatchListEmpty extends TvWatchListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvWatchListLoading extends TvWatchListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvWatchListError extends TvWatchListState {
  final String message;

  TvWatchListError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class TvWatchListHasData extends TvWatchListState {
  final List<Tv> result;

  TvWatchListHasData(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}

class TvWatchListIsAdded extends TvWatchListState {
  final bool isAdded;

  TvWatchListIsAdded(this.isAdded);

  @override
  // TODO: implement props
  List<Object?> get props => [isAdded];
}

class TvWatchListMessage extends TvWatchListState {
  final String message;

  TvWatchListMessage(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

