// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '/Models/enums.dart';
import '/Models/user.dart';

import '/Redux/App/app_state.dart';
import '/Redux/selectors.dart';

import '/Utils/console_log.dart';

@immutable
class UserViewModel {
  final LoadingStatus loadingStatus;

  final User user;

  final IList<String> organizedEventsIds;

  const UserViewModel({
    required this.loadingStatus,
    required this.user,
    required this.organizedEventsIds,
  });

  factory UserViewModel.create(Store<AppState> store, String idUser) {
    logWarning("UserViewModel.create(store) called on user: ${userSel(store, idUser)}");

    return UserViewModel(
      loadingStatus: usersLoadingStatusSel(store),
      user: userSel(store, idUser) ?? User.empty(),
      organizedEventsIds: userOrganizedEventsIdsSel(store, idUser),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserViewModel &&
        other.loadingStatus == loadingStatus &&
        other.user == user &&
        other.organizedEventsIds == organizedEventsIds;
  }

  @override
  int get hashCode => loadingStatus.hashCode ^ user.hashCode ^ organizedEventsIds.hashCode;
}
