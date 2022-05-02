import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_list_api_v2/src/actions/index.dart';
import 'package:movie_list_api_v2/src/models/app_user.dart';

part 'login.freezed.dart';

@freezed
class Login with _$Login implements AppAction {
  const factory Login({
    required String email,
    required String password,
    required ActionResult onResult,
  }) = LoginStart;

  const factory Login.successful(AppUser user) = LoginSuccessful;

  @Implements<ErrorAction>()
  const factory Login.error(Object error, StackTrace stackTrace) = LoginError;
}
