import 'package:flutter/cupertino.dart';
import 'package:movie_list_api_v2/src/models/movie.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  AppState({this.movies = const <Movie>[], this.isLoading = true, this.pageNumber = 1});

  final List<Movie> movies;
  final bool isLoading;
  final int pageNumber;

  AppState copyWith({
    List<Movie>? movies,
    bool? isLoading,
    int? pageNumber,
  }) {
    return AppState(
      movies: movies != null ? List<Movie>.unmodifiable(movies) : this.movies,
      isLoading: isLoading ?? this.isLoading,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }
}
