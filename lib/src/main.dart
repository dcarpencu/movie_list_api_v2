import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:movie_list_api_v2/src/actions/getmovies.dart';
import 'package:movie_list_api_v2/src/data/movie_api.dart';
import 'package:movie_list_api_v2/src/epics/app_epic.dart';
import 'package:movie_list_api_v2/src/models/app_state.dart';
import 'package:movie_list_api_v2/src/presentation/home_page.dart';
import 'package:movie_list_api_v2/src/reducer/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

void main() {
  final Client client = Client();
  final MovieApi movieApi = MovieApi(client);
  final AppEpic epic = AppEpic(movieApi);

  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: AppState(),
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(epic.getEpics()),
    ],
  );

  store.dispatch(GetMovies(1));

  runApp(MoviesApp(store: store));
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
