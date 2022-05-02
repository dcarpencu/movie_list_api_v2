import 'package:flutter/foundation.dart';
import 'package:movie_list_api_v2/src/actions/index.dart';
import 'package:movie_list_api_v2/src/models/index.dart';
import 'package:movie_list_api_v2/src/reducer/auth_reducer.dart';
import 'package:movie_list_api_v2/src/reducer/movie_reducer.dart';
import 'package:redux/redux.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is! AppAction) {
    throw ArgumentError('All actions should implement AppActions');
  }

  if (kDebugMode) {
    print(action);
  }
  final AppState newState = _reducer(state, action);

  if (kDebugMode) {
    print(newState);
  }

  return newState;
}

Reducer<AppState> _reducer = combineReducers<AppState>(<Reducer<AppState>>[
  authReducer,
  movieReducer,
]);
