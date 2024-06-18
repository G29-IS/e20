import 'package:flutter/widgets.dart';

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
  final BuildContext context;
  LoginAction(this.email, this.password, this.context);
}

class PasswordForgottenAction {
  final String email;
  PasswordForgottenAction(this.email);
}

class LogoutAction {
  final BuildContext context;
  LogoutAction(this.context);
}

class LoginWithGoogleAction {
  LoginWithGoogleAction();
}

class FetchCurrentUserAction {
  FetchCurrentUserAction();
}
