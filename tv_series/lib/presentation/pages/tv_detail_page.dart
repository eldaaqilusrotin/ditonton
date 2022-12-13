import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvDetailPage extends StatefulWidget {
  final int id;
  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(OnTvDetail(widget.id));
      context.read<TvRecommendationsBloc>().add(OnTvRecommendations(widget.id));
      context.read<TvWatchListBloc>().add(TvWatchListStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTvShowAddedToWatchlist = context.select<TvWatchListBloc, bool>(
            (bloc) => (bloc.state is TvWatchListIsAdded)
            ? (bloc.state as TvWatchListIsAdded).isAdded
            : false);

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<TvDetailBloc, TvState>(
          builder: (context, state) {
            if (state is TvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvDetailHasData) {

              final tvRecommendations = context
                  .select<TvRecommendationsBloc, List<Tv>>(
                      (TvRecommendationsBloc result) {
                    final state = result.state;
                    return state is TvListHasData ? state.result : [];
                  });
              final tv = state.result;
              return ContentDetails(
                  tvDetail: tv, isAddedWatchlistTv: isTvShowAddedToWatchlist, recommendations: tvRecommendations,);
            } else {
              return const Center(
                child: Text("Failed"),
              );
            }
          },
        ),
      ),
    );
  }
}

class ContentDetails extends StatefulWidget {
  final TvDetail tvDetail;
  bool isAddedWatchlistTv;
  final List<Tv> recommendations;


  ContentDetails({Key? key, required this.tvDetail, required this.isAddedWatchlistTv, required this.recommendations}) : super(key: key);

  @override
  State<ContentDetails> createState() => _ContentDetailsState();
}

class _ContentDetailsState extends State<ContentDetails> {
  @override
  Widget build(BuildContext context) {
    return ScrollableSheet(
        background: "$BASE_IMAGE_URL${widget.tvDetail.posterPath}",
        scrollableContents: [
          Text(
            widget.tvDetail.name,
            style: heading5,
          ),
          ElevatedButton(
            onPressed: () async {
              if (!widget.isAddedWatchlistTv) {
                context
                    .read<TvWatchListBloc>()
                    .add(TvWatchListAdd(widget.tvDetail));
              } else {
                context
                    .read<TvWatchListBloc>()
                    .add(TvWatchListRemove(widget.tvDetail));
              }

              final state = BlocProvider.of<TvWatchListBloc>(context).state;
              String message = "";

              if (state is TvWatchListIsAdded) {
                final isAdded = state.isAdded;
                message = isAdded == false ? notifAdd : notifRemove;
              } else {
                message =
                !widget.isAddedWatchlistTv ? notifAdd : notifRemove;
              }

              if (message == notifAdd || message == notifRemove) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(message),
                      );
                    });
              }

              setState(() {
                widget.isAddedWatchlistTv = !widget.isAddedWatchlistTv;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.isAddedWatchlistTv
                    ? const Icon(Icons.check)
                    : const Icon(Icons.add),
                const SizedBox(width: 6.0),
                const Text('Watchlist'),
                const SizedBox(width: 4.0),
              ],
            ),
          ),
          Text(_showGenres(widget.tvDetail.genres)),
          Row(
            children: [
              const Text('Last episode : '),
              Text(
                '${widget.tvDetail.lastEpisodeToAir.episodeNumber}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Number of episode : '),
              Text(
                '${widget.tvDetail.numberOfEpisodes}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Row(
            children: [
              RatingBarIndicator(
                rating: widget.tvDetail.voteAverage / 2,
                itemCount: 5,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: kYellow,
                ),
                itemSize: 24,
              ),
              Text("${widget.tvDetail.voteAverage}")
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Season List',
            style: heading6,
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.tvDetail.seasons.length,
              itemBuilder: (context, index) {
                final tvSeason = widget.tvDetail.seasons
                    .map((e) => e.seasonNumber)
                    .elementAt(index);

                return Padding(
                  key: Key('season_$index'),
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        tvSeasonDetailRoute,
                        arguments: MultiArgument(
                          widget.tvDetail.id,
                          tvSeason,
                        ),
                      );
                    },
                    child: Text('Season $tvSeason'),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Overview",
            style: heading6,
          ),
          Text(widget.tvDetail.overview.isNotEmpty
              ? widget.tvDetail.overview
              : "-"),
          const SizedBox(
            height: 12,
          ),

          const SizedBox(
            height: 16,
          ),
          Text(
            "Recommendations",
            style: heading6,
          ),

          BlocBuilder<TvRecommendationsBloc, TvState>(
            builder: (context, state) {
              if (state is TvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvError) {
                return Text(state.message);
              } else if (state is TvListHasData) {
                return SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final tv = widget.recommendations[index];
                      return Padding(
                        key: Key('recommendation_$index'),
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              tvDetailRoute,
                              arguments: tv.id,
                            );
                          },
                          child: ClipRRect(
                            borderRadius:
                            const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                              '$baseImageUrl${tv.posterPath}',
                              placeholder: (context, url) =>
                              const Center(
                                child:
                                CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: widget.recommendations.length,
                  ),
                );
              } else {
                return const Text('No recommendations found');
              }
            },
          )
        ]);
  }


  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }
    if (result.isEmpty) {
      return result;
    }
    return result.substring(0, result.length - 2);
  }
}
