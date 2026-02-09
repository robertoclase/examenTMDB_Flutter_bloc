import 'package:tmdb_api/core/models/movies_list_popular_response.dart';

abstract class MoviesListInterface {
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> getTopRatedMovies();
}
