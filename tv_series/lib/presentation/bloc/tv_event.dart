part of 'tv_bloc.dart';

abstract class TvEvent extends Equatable {
  const TvEvent();

  @override
  List<Object> get props => [];
}

class OnNowPlayingTv extends TvEvent {}

class OnPopularTv extends TvEvent {}

class OnTopRatedTv extends TvEvent {}

abstract class TvRecommendationEvent extends Equatable {}

class OnTvRecommendations extends TvEvent {
  final int id;
  const OnTvRecommendations(this.id);

  @override
  List<Object> get props => [id];
}


class OnTvDetail extends TvEvent {
  final int id;
  const OnTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnTvSeasonDetail extends TvEvent {
  final int id;
  final int seasonNumber;

  const OnTvSeasonDetail(this.id, this.seasonNumber);

  @override
  List<Object> get props => [id, seasonNumber];
}

class OnTvEpisodeDetail extends TvEvent {
  final int id;
  final int seasonNumber;
  final int episodeNumber;

  const OnTvEpisodeDetail(
    this.id,
    this.seasonNumber,
    this.episodeNumber,
  );

  @override
  List<Object> get props => [id, seasonNumber, episodeNumber];
}

class OnTvWatchlist extends TvEvent {}

abstract class TvWatchListEvent extends Equatable {}

class OnFetchTvWatchList extends TvWatchListEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvWatchListStatus extends TvWatchListEvent {
  final int id;

  TvWatchListStatus(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class TvWatchListAdd extends TvWatchListEvent {
  final TvDetail tvDetail;

  TvWatchListAdd(this.tvDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [tvDetail];
}

class TvWatchListRemove extends TvWatchListEvent {
  final TvDetail tvDetail;

  TvWatchListRemove(this.tvDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [tvDetail];
}


class OnAddTvWatchlist extends TvEvent {
  final TvDetail tvDetail;
  const OnAddTvWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class OnRemoveTvWatchlist extends TvEvent {
  final TvDetail tvDetail;
  const OnRemoveTvWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
