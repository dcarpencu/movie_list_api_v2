import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_list_api_v2/src/models/index.dart';

part 'index.freezed.dart';
part 'login.dart';
part 'getmovies.dart';
part 'get_current_user.dart';
part 'create_user.dart';
part 'update_favorites.dart';

abstract class AppAction {}

abstract class ErrorAction implements AppAction {
  Object get error;

  StackTrace get stackTrace;
}

abstract class UserAction extends AppAction {
  AppUser? get user;
}

typedef ActionResult = void Function(AppAction action);
