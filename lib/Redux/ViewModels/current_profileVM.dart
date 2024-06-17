// ignore_for_file: file_names

import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '/Models/enums.dart';
import '/Models/user.dart';

import '/Redux/App/app_state.dart';
import '/Redux/selectors.dart';
import '/Redux/Auth/auth_actions.dart';

import '/Utils/console_log.dart';

@immutable
class CurrentProfileViewModel {
  final LoadingStatus loadingStatus;

  final User user;

  final IList<String> organizedEventsIds;

  final Function(String email) resetPassword;

  final Function(
    String username,
    String password,
    BuildContext context,
  ) login;

  final Function logout;

  const CurrentProfileViewModel({
    required this.loadingStatus,
    required this.user,
    required this.organizedEventsIds,
    required this.resetPassword,
    required this.login,
    required this.logout,
  });

  factory CurrentProfileViewModel.create(Store<AppState> store) {
    logWarning("CurrentPRofileViewModel.create(store) called: ${currentUserSel(store)}");

    _login(String username, String password, BuildContext context) {
      store.dispatch(LoginAction(username, password, context));
    }

    _logout() {
      store.dispatch(LogoutAction());
    }

    _resetPassword(String email) {
      store.dispatch(PasswordForgottenAction(email));
    }

    return CurrentProfileViewModel(
      loadingStatus: authLoadingStatusSel(store),
      user: currentUserSel(store) ?? User.empty(),
      organizedEventsIds: currentUserOrganizedEventsIdsSel(store),
      resetPassword: _resetPassword,
      login: _login,
      logout: _logout,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrentProfileViewModel &&
        other.loadingStatus == loadingStatus &&
        other.user == user &&
        other.organizedEventsIds == organizedEventsIds;
  }

  @override
  int get hashCode => loadingStatus.hashCode ^ user.hashCode ^ organizedEventsIds.hashCode;
}
