import 'package:movie_list_api_v2/src/actions/getmovies.dart';
import 'package:movie_list_api_v2/src/data/movie_api.dart';
import 'package:movie_list_api_v2/src/models/app_state.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class AppEpic {
  AppEpic(this._movieApi);

  final MovieApi _movieApi;

  Epic<AppState> getEpics() {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, GetMovies>(_getMovies),
    ]);
  }

  Stream<dynamic> _getMovies(Stream<GetMovies> actions, EpicStore<AppState> store) {
    return actions
        .asyncMap((GetMovies action) => _movieApi.getMovies(store.state.pageNumber))
        .map<dynamic>(GetMoviesSuccessful.new)
        .onErrorReturnWith((Object error, StackTrace stackTrace) => GetMoviesError(error));
  }
}
