import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:flutter/material.dart';


class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieNowPlayingBloc>().add(OnMovieNowPLayingCalled());
      context.read<MovieTopRatedBloc>().add(OnMovieTopRated());
      context.read<MoviePopularBloc>().add(OnMoviePopular());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Elda Aqil Usrotin'),
              accountEmail: Text('eldaaaql@gmail.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Tv Series'),
              onTap: () {
                Navigator.pushReplacementNamed(context, homeTvRoute);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, watchlistRoute);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, aboutRoute);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton -Movies-', style: subtitle),
        actions: [
          IconButton(
            key: const Key('search_movie'),
            onPressed: () {
              Navigator.pushNamed(context, searchMoviesRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                valueKey: 'now_playing_movies',
                onTap: () =>
                    Navigator.pushNamed(context, nowPlayingMoviesRoute),
              ),
              BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
                  builder: (context, state) {
                    if (state is MovieNowPlayingLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is MovieNowPlayingHasData) {
                      final data = state.result;
                      return MovieList(data);
                    } else if (state is MovieNowPlayingError) {
                      return const Text("Failed");
                    } else {
                      return Container();
                    }
                  }),
              _buildSubHeading(
                title: 'Popular',
                valueKey: 'popular_movies',
                onTap: () => Navigator.pushNamed(context, popularMoviesRoute),
              ),
              BlocBuilder<MoviePopularBloc, MoviePopularState>(
                  builder: (context, state) {
                    if (state is MoviePopularLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is MoviePopularHasData) {
                      final data = state.result;
                      return MovieList(data);
                    } else if (state is MoviePopularError) {
                      return const Text("Failed");
                    } else {
                      return Container();
                    }
                  }),
              _buildSubHeading(
                title: 'Top Rated',
                valueKey: 'top_rated_movies',
                onTap: () => Navigator.pushNamed(context, topRatedMoviesRoute),
              ),
              BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                  builder: (context, state) {
                    if (state is MovieTopRatedLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is MovieTopRatedHasData) {
                      final data = state.result;
                      return MovieList(data);
                    } else if (state is MovieTopRatedError) {
                      return const Text("Failed");
                    } else {
                      return Container();
                    }
                  }),
            ],
          ),

        ),
      ),
    );
  }

  Row _buildSubHeading({
    required String title,
    required Function() onTap,
    required String valueKey,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: heading6,
        ),
        InkWell(
          onTap: onTap,
          key: Key(valueKey),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  movieDetailRoute,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
