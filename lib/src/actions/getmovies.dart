import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_list_api_v2/src/actions/index.dart';
import 'package:movie_list_api_v2/src/models/movie.dart';

part 'getmovies.freezed.dart';

@freezed
class GetMovies with _$GetMovies implements AppAction {
  const factory GetMovies(ActionResult onResult) = GetMoviesStart;

  const factory GetMovies.successful(List<Movie> movies) = GetMoviesSuccessful;

  @Implements<ErrorAction>()
  const factory GetMovies.error(Object error, StackTrace stackTrace) = GetMoviesError;
}
