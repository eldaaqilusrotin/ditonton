import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core/core.dart';
import 'dart:async';

part 'tv_event.dart';
part 'tv_state.dart';

class NowPlayingTvBloc extends Bloc<TvEvent, TvState> {
  final GetNowPlayingTv getNowPlayingTv;

  NowPlayingTvBloc(this.getNowPlayingTv) : super(TvEmpty()) {
    on<OnNowPlayingTv>((event, emit) async {
      emit(TvLoading());

      final getNowPlayingTvResult = await getNowPlayingTv.execute();

      getNowPlayingTvResult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (tvData) => emit(
          TvListHasData(tvData),
        ),
      );
    });
  }
}

class PopularTvBloc extends Bloc<TvEvent, TvState> {
  final GetPopularTv getPopularTv;

  PopularTvBloc(this.getPopularTv) : super(TvEmpty()) {
    on<OnPopularTv>((event, emit) async {
      emit(TvLoading());

      final getPopularTvResult = await getPopularTv.execute();

      getPopularTvResult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (tvData) => emit(
          TvListHasData(tvData),
        ),
      );
    });
  }
}

class TopRatedTvBloc extends Bloc<TvEvent, TvState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvBloc(this.getTopRatedTv) : super(TvEmpty()) {
    on<OnTopRatedTv>((event, emit) async {
      emit(TvLoading());

      final getTopRatedTvResult = await getTopRatedTv.execute();

      getTopRatedTvResult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (tvData) => emit(
          TvListHasData(tvData),
        ),
      );
    });
  }
}

class TvRecommendationsBloc extends Bloc<TvEvent, TvState> {
  final GetTvRecommendations getTvRecommendations;

  TvRecommendationsBloc(this.getTvRecommendations) : super(TvEmpty()) {
    on<OnTvRecommendations>((event, emit) async {
      final id = event.id;

      emit(TvLoading());

      final getTvRecommendationsResult = await getTvRecommendations.execute(id);

      getTvRecommendationsResult.fold(
            (failure) => emit(
          TvError(failure.message),
        ),
            (tv) => emit(
          TvListHasData(tv),
        ),
      );
    });
  }
}

class TvDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetail getTvDetail;

  TvDetailBloc(this.getTvDetail) : super(TvEmpty()) {
    on<OnTvDetail>((event, emit) async {
      final id = event.id;

      emit(TvLoading());

      final getTvDetailResult = await getTvDetail.execute(id);

      getTvDetailResult.fold(
            (failure) => emit(
          TvError(failure.message),
        ),
            (tv) => emit(
          TvDetailHasData(tv),
        ),
      );
    });
  }
}



class TvSeasonDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvSeasonDetail getTvSeasonDetail;

  TvSeasonDetailBloc(this.getTvSeasonDetail) : super(TvEmpty()) {
    on<OnTvSeasonDetail>((event, emit) async {
      final id = event.id;
      final seasonNumber = event.seasonNumber;

      emit(TvLoading());

      final getTvSeasonDetailresult =
          await getTvSeasonDetail.execute(id, seasonNumber);

      getTvSeasonDetailresult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (tvSeason) => emit(
          TvSeasonDetailHasData(tvSeason),
        ),
      );
    });
  }
}

class TvEpisodeDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvEpisodeDetail getTvEpisodeDetail;

  TvEpisodeDetailBloc(this.getTvEpisodeDetail) : super(TvEmpty()) {
    on<OnTvEpisodeDetail>((event, emit) async {
      final id = event.id;
      final seasonNumber = event.seasonNumber;
      final episodeNumber = event.episodeNumber;

      emit(TvLoading());

      final getTvEpisodeDetailresult =
          await getTvEpisodeDetail.execute(id, seasonNumber, episodeNumber);

      getTvEpisodeDetailresult.fold(
        (failure) => emit(
          TvError(failure.message),
        ),
        (tvEpisode) => emit(TvEpisodeDetailHasData(tvEpisode)),
      );
    });
  }
}

class TvWatchListBloc extends Bloc<TvWatchListEvent, TvWatchListState> {
  final GetWatchlistTv _getWatchlistTv;
  final GetTvWatchListStatus _getWatchlistStatusTv;
  final RemoveTvWatchlist _removeWatchlistTv;
  final SaveTvWatchlist _saveWatchlistTv;

  TvWatchListBloc(this._getWatchlistTv, this._getWatchlistStatusTv,
      this._removeWatchlistTv, this._saveWatchlistTv)
      : super(TvWatchListInitial()) {
    on<OnFetchTvWatchList>(_onFetchTvWatchList);
    on<TvWatchListStatus>(_onTvWatchListStatus);
    on<TvWatchListAdd>(_onTvWatchListAdd);
    on<TvWatchListRemove>(_onTvWatchListRemove);
  }

  FutureOr<void> _onFetchTvWatchList(
      OnFetchTvWatchList event, Emitter<TvWatchListState> emit) async {
    emit(TvWatchListLoading());
    final result = await _getWatchlistTv.execute();
    result.fold((failure) {
      emit(TvWatchListError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TvWatchListEmpty())
          : emit(TvWatchListHasData(success));
    });
  }

  FutureOr<void> _onTvWatchListStatus(
      TvWatchListStatus event, Emitter<TvWatchListState> emit) async {
    final id = event.id;
    final result = await _getWatchlistStatusTv.execute(id);
    emit(TvWatchListIsAdded(result));
  }

  FutureOr<void> _onTvWatchListAdd(
      TvWatchListAdd event, Emitter<TvWatchListState> emit) async {
    final tv = event.tvDetail;
    final result = await _saveWatchlistTv.execute(tv);
    result.fold((failure) {
      emit(TvWatchListError(failure.message));
    }, (success) {
      emit(TvWatchListMessage(success));
    });
  }

  FutureOr<void> _onTvWatchListRemove(
      TvWatchListRemove event, Emitter<TvWatchListState> emit) async {
    final tv = event.tvDetail;
    final result = await _removeWatchlistTv.execute(tv);

    result.fold((failure) {
      emit(TvWatchListError(failure.message));
    }, (success) {
      emit(TvWatchListMessage(success));
    });
  }
}

