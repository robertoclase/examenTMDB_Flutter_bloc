import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tmdb_api/core/interfaces/movies_list_interface.dart';
import 'package:tmdb_api/core/models/movies_list_popular_response.dart';

class MovieService implements MoviesListInterface {
  final String _apiBaseUrl = "https://api.themoviedb.org/3/movie";
  final String _accessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNTI0NTUxOTFiZGY0ZjA3YjFlNjAxZWY4OTI1OGRiMiIsIm5iZiI6MTc2MzM2NzU4Mi45MzEsInN1YiI6IjY5MWFkYTllYmQ0ZjI0N2UxYTE3NWNhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GLP0OEmX7QvDPJENJnsNm093o1elbs88l6xZEVz-Nps";

  @override
  Future<List<Movie>> getPopularMovies() async {
    var response = await http.get(
      Uri.parse("$_apiBaseUrl/popular"),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var moviesList = MovieListPopularResponse.fromJson(
          json.decode(response.body),
        ).results;
        return moviesList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error al obtener las películas populares");
    }
  }

  @override
  Future<List<Movie>> getTopRatedMovies() async {
    var response = await http.get(
      Uri.parse("$_apiBaseUrl/top_rated"),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var moviesList = MovieListPopularResponse.fromJson(
          json.decode(response.body),
        ).results;
        return moviesList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Error al obtener las películas top rated");
    }
  }
}
