import 'package:flutter/foundation.dart' show immutable;
import 'package:redux/redux.dart';

import '/Models/enums.dart';
import '/Models/user.dart';

import '/Redux/App/app_state.dart';
import '/Redux/selectors.dart';

import '/Utils/console_log.dart';

@immutable
class CurrentProfileViewModel {
  final LoadingStatus loadingStatus;

  final User user;

  const CurrentProfileViewModel({
    required this.loadingStatus,
    required this.user,
  });

  factory CurrentProfileViewModel.create(Store<AppState> store) {
    logWarning("CurrentPRofileViewModel.create(store) called: ${currentUserSel(store)}");

    return CurrentProfileViewModel(
      loadingStatus: authLoadingStatusSel(store),
      user: currentUserSel(store) ?? User.empty(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrentProfileViewModel && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}
