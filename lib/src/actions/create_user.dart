import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_list_api_v2/src/actions/index.dart';
import 'package:movie_list_api_v2/src/models/app_user.dart';

part 'create_user.freezed.dart';

@freezed
class CreateUser with _$CreateUser implements AppAction {
  const factory CreateUser({
    required String email,
    required String password,
    required String username,
    required ActionResult onResult,
  }) = CreateUserStart;

  const factory CreateUser.successful(AppUser user) = CreateUserSuccessful;

  @Implements<ErrorAction>()
  const factory CreateUser.error(Object error, StackTrace stackTrace) = CreateUserError;
}
