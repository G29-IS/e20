import 'package:e20/models/enums.dart';
import 'package:e20/models/user.dart';

class SetAuthLoadingStatusAction {
  final LoadingStatus loadingStatus;
  SetAuthLoadingStatusAction(this.loadingStatus);
}

class SetCurrentUserAction {
  final User? currentUser;
  final String? token;

  SetCurrentUserAction(this.currentUser, this.token);
}

class LoginAction {
  final String email;
  final String password;
  LoginAction(this.email, this.password);
}

class LoginWithGoogleAction {
  LoginWithGoogleAction();
}
