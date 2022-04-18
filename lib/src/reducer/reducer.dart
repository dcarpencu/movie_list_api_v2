import 'package:movie_list_api_v2/src/actions/getmovies.dart';
import 'package:movie_list_api_v2/src/models/movie.dart';
import 'package:movie_list_api_v2/src/models/app_state.dart';
import 'package:redux/redux.dart';

AppState reducer(AppState state, dynamic action) {
  print(action);
  final AppState newState = _reducer(state, action);
  print(newState);
  return newState;
}

Reducer<AppState> _reducer = combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
]);

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  return state.copyWith(movies: <Movie>[...state.movies, ...action.movies]);
}
