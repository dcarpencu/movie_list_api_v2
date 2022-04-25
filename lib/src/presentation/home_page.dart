import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_list_api_v2/src/actions/getmovies.dart';
import 'package:movie_list_api_v2/src/models/app_state.dart';
import 'package:movie_list_api_v2/src/models/movie.dart';
import 'package:redux/redux.dart' show Store;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (Store<AppState> store) => store.state,
      builder: (BuildContext context, AppState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Movies ${state.pageNumber}'),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  StoreProvider.of<AppState>(context).dispatch(GetMovies());
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
          body: Builder(
            builder: (BuildContext context) {
              if (state.isLoading && state.movies.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: state.movies.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Movie movie = state.movies[index];

                    return Column(
                      children: <Widget>[
                        Image.network(movie.poster),
                        Text('${movie.year}'),
                        Text(movie.genres.join(', ')),
                        Text('${movie.rating}'),
                      ],
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
