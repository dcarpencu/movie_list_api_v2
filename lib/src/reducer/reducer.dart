import 'package:movie_list_api_v2/src/actions/getmovies.dart';
import 'package:movie_list_api_v2/src/models/app_state.dart';
import 'package:movie_list_api_v2/src/models/movie.dart';
import 'package:redux/redux.dart';

AppState reducer(AppState state, dynamic action) {
  print(action);
  final AppState newState = _reducer(state, action);
  print(newState);
  return newState;
}

Reducer<AppState> _reducer = combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, GetMovies>(_getMovies),
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
  TypedReducer<AppState, GetMoviesError>(_getMoviesError),
]);

AppState _getMovies(AppState state, GetMoviesSuccessful action) {
  return state.copyWith(isLoading: true);
}

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  return state.copyWith(
      isLoading: false,
      movies: <Movie>[...state.movies, ...action.movies]);
}

AppState _getMoviesError(AppState state, GetMoviesSuccessful action) {
  return state.copyWith(isLoading: false);
}