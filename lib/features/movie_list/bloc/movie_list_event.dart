part of 'movie_list_bloc.dart';

@immutable
sealed class MovieListEvent {}

final class MovieListFetchPopularEvent extends MovieListEvent {}

final class MovieListFetchTopRatedEvent extends MovieListEvent {}
