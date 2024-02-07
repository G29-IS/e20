import '/Models/enums.dart';
import '/Models/user.dart';

class SetAuthLoadingStatusAction {
  final LoadingStatus loadingStatus;
  SetAuthLoadingStatusAction(this.loadingStatus);
}

class SetAuthTokenAction {
  final String authToken;
  SetAuthTokenAction(this.authToken);
}

class RemoveAuthTokenAction {
  RemoveAuthTokenAction();
}

class SetCurrentUserAction {
  final User currentUser;

  SetCurrentUserAction(this.currentUser);
}

class LoginAction {
  final String email;
  final String password;
  LoginAction(this.email, this.password);
}

class LogoutAction {
  LogoutAction();
}

class LoginWithGoogleAction {
  LoginWithGoogleAction();
}

class FetchCurrentUserAction {
  FetchCurrentUserAction();
}
