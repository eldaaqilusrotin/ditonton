import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:flutter/material.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
            () => context.read<MovieWatchListBloc>().add(OnFetchMovieWatchList()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Future.microtask(
            () => context.read<MovieWatchListBloc>().add(OnFetchMovieWatchList()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieWatchListBloc, MovieWatchListState>(
            builder: (context, state) {
              if (state is MovieWatchListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovieWatchListHasData) {
                final data = state.result;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final movie = data[index];
                    return MovieCard(movie, index);
                  },
                );
              } else if (state is MovieWatchListEmpty) {
                return const Center(
                  child: Text("Watchlist Empty",selectionColor: Colors.red,),
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
