import 'package:flutter/foundation.dart' show immutable;
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

  final Function(
    String username,
    String password,
  ) login;

  final Function logout;

  const CurrentProfileViewModel({
    required this.loadingStatus,
    required this.user,
    required this.organizedEventsIds,
    required this.login,
    required this.logout,
  });

  factory CurrentProfileViewModel.create(Store<AppState> store) {
    logWarning("CurrentPRofileViewModel.create(store) called: ${currentUserSel(store)}");

    _login(String username, String password) {
      store.dispatch(LoginAction(username, password));
    }

    _logout() {
      store.dispatch(LogoutAction());
    }

    return CurrentProfileViewModel(
      loadingStatus: authLoadingStatusSel(store),
      user: currentUserSel(store) ?? User.empty(),
      organizedEventsIds: currentUserOrganizedEventsIdsSel(store),
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
