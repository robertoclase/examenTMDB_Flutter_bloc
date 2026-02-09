import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_api/core/services/movie_service.dart';
import 'package:tmdb_api/features/movie_list/bloc/movie_list_bloc.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late MovieListBloc movieListBloc;
  String selectedCategory = 'popular';

  @override
  void initState() {
    super.initState();
    movieListBloc = MovieListBloc(MovieService())
      ..add(MovieListFetchPopularEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Peliculas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'popular';
                      });
                      movieListBloc.add(MovieListFetchPopularEvent());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selectedCategory == 'popular'
                            ? Colors.teal
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        'Popular',
                        style: TextStyle(
                          color: selectedCategory == 'popular'
                              ? Colors.black
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'toprated';
                      });
                      movieListBloc.add(MovieListFetchTopRatedEvent());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selectedCategory == 'toprated'
                            ? Colors.teal
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        'Top Rated',
                        style: TextStyle(
                          color: selectedCategory == 'toprated'
                              ? Colors.black
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieListBloc, MovieListState>(
              bloc: movieListBloc,
              builder: (context, state) {
                if (state is MovieListLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is MovieListError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                if (state is MovieListSuccess) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.movieList.length,
                    itemBuilder: (context, index) {
                      final movie = state.movieList[index];
                      return Container(
                        width: 150,
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                    height: 220,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  left: 5,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.teal,
                                    radius: 20,
                                    child: Text(
                                      '${(movie.voteAverage * 10).toInt()}%',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              movie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              movie.releaseDate ?? '',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
