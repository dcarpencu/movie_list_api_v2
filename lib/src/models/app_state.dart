import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_list_api_v2/src/models/app_user.dart';
import 'package:movie_list_api_v2/src/models/movie.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(<Movie>[]) List<Movie> movies,
    @Default(true) bool isLoading,
    @Default(1) int pageNumber,
    AppUser? user,
  }) = AppState$;
}
