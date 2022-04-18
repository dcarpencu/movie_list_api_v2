import 'package:movie_list_api_v2/src/models/movie.dart';

class GetMovies {
  GetMovies(this.page);

  final int page;

  @override
  String toString() {
    return 'GetMovies{page: $page}';
  }
}

class GetMoviesSuccessful {
  GetMoviesSuccessful(this.movies);
  final List<Movie> movies;

  @override
  String toString() {
    return 'GetMoviesSuccessful{movies: $movies}';
  }
}

class GetMoviesError {
  GetMoviesError(this.error);

  final Object error;

  @override
  String toString() {
    return 'GetMoviesError{error: $error}';
  }
}
