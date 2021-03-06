import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_list_api_v2/src/actions/index.dart';
import 'package:movie_list_api_v2/src/containers/home_page_container.dart';
import 'package:movie_list_api_v2/src/containers/movies_container.dart';
import 'package:movie_list_api_v2/src/containers/user_container.dart';
import 'package:movie_list_api_v2/src/models/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    StoreProvider.of<AppState>(context, listen: false).dispatch(GetMovies(_onResult));
  }

  void _onResult(AppAction action) {
    if (action is GetMoviesSuccessful) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Page Loaded')));
    } else if (action is GetMoviesError) {
      final Object error = action.error;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error has occurred $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomePageContainer(
      builder: (BuildContext context, AppState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Movies ${state.pageNumber}'),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  StoreProvider.of<AppState>(context).dispatch(GetMovies(_onResult));
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
          body: MoviesContainer(
            builder: (BuildContext context, List<Movie> movies) {
              if (state.isLoading && movies.isEmpty) {
                return const Center(
                    child: CircularProgressIndicator(),);
              }
                return UserContainer(
                  builder: (BuildContext context, AppUser? user) {
                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Movie movie = movies[index];
                      final bool isFavorite = user!.favoriteMovies.contains(movie.id);

                      return Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Image.network(movie.poster),
                              IconButton(
                                color: Colors.red,
                                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                                onPressed: () {
                                  StoreProvider.of<AppState>(context)
                                      .dispatch(UpdateFavorite(movie.id, add: !isFavorite));
                                },
                            )
                          ],
                          ),
                          Text('${movie.year}'),
                          Text(movie.genres.join(', ')),
                          Text('${movie.rating}'),
                        ],
                      );
                    },
                  );
              },);
            },
          ),
        );
      },
    );
  }
}
