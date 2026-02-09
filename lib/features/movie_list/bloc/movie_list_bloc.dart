import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_api/core/models/movies_list_popular_response.dart';
import 'package:tmdb_api/core/services/movie_service.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieService movieService;

  MovieListBloc(this.movieService) : super(MovieListInitial()) {
    on<MovieListFetchPopularEvent>((event, emit) async {
      emit(MovieListLoading());
      try {
        var apiMovieList = await movieService.getPopularMovies();
        emit(MovieListSuccess(movieList: apiMovieList));
      } catch (e) {
        emit(MovieListError(message: e.toString()));
      }
    });

    on<MovieListFetchTopRatedEvent>((event, emit) async {
      emit(MovieListLoading());
      try {
        var apiMovieList = await movieService.getTopRatedMovies();
        emit(MovieListSuccess(movieList: apiMovieList));
      } catch (e) {
        emit(MovieListError(message: e.toString()));
      }
    });
  }
}
