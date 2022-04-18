import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_list_api_v2/src/models/app_state.dart';
import 'package:redux/redux.dart';
import '../actions/getmovies.dart';
import '../file_01.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final AppState state = store.state;
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies ${state.pageNumber}'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  store.dispatch(GetMovies(state.pageNumber + 1));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Builder(builder: (BuildContext context) {
          if (state.isLoading && state.movies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                itemCount: state.movies.length,
                itemBuilder: (BuildContext context, int index) {
                  final Movie movie = state.movies[index] as Movie;

                  return Column(children: <Widget>[
                    Image.network(movie.poster),
                    Text('${movie.year}'),
                    Text(movie.genres.join(', ')),
                    Text('${movie.rating}'),
                  ]);
                });
          }
        }));
  }
}
