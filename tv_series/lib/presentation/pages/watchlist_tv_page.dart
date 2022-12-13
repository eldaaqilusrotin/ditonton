import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';

class WatchlistTvPage extends StatefulWidget {
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
            () => context.read<TvWatchListBloc>().add(OnFetchTvWatchList()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<TvWatchListBloc>().add(OnFetchTvWatchList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvWatchListBloc, TvWatchListState>(
            builder: (context, state) {
              if (state is TvWatchListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvWatchListHasData) {
                final data = state.result;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final tv = data[index];
                    return TvCard(tv, index);
                  },
                );
              } else if (state is TvWatchListEmpty) {
                return const Center(
                  child: Text("Watchlist Empty"),
                );
              } else {
                return const Center(
                  key: Key("error_message"),
                  child: Text("Failed"),
                );
              }
            }),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
