import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_list_api_v2/src/models/app_state.dart';
import 'package:movie_list_api_v2/src/models/app_user.dart';
import 'package:movie_list_api_v2/src/models/movie.dart';
import 'package:redux/redux.dart' show Store;

class UserContainer extends StatelessWidget {
  const UserContainer({Key? key, required this.builder}) : super(key: key);

  final ViewModelBuilder<AppUser?> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppUser?>(
      converter: (Store<AppState> store) => store.state.user,
      builder: builder,
    );
  }
}
