import 'package:redux/redux.dart';

import '/Redux/Users/users_state.dart';
import '/Redux/Users/users_actions.dart';

final usersReducers = combineReducers<UsersState>([
  TypedReducer<UsersState, SetUsersLoadingStatusAction>(_setUsersLoadingStatus),
  TypedReducer<UsersState, SaveUserAction>(_saveUser),
  TypedReducer<UsersState, SetCurrentUserOrganizedEventsIdsAction>(
      _setCurrentUserOrganizedEventsIds),
]);

UsersState _setUsersLoadingStatus(UsersState state, SetUsersLoadingStatusAction action) {
  return state.copyWith(usersLoadingStatus: action.loadingStatus);
}

UsersState _saveUser(UsersState state, SaveUserAction action) {
  return state.copyWith(
    users: state.users.add(action.idUser, action.user),
    eventsOrganizedByUser: state.eventsOrganizedByUser.add(
      action.idUser,
      action.organizedEventsIds,
    ),
  );
}

UsersState _setCurrentUserOrganizedEventsIds(
    UsersState state, SetCurrentUserOrganizedEventsIdsAction action) {
  return state.copyWith(
    eventsOrganizedByUser: state.eventsOrganizedByUser.add(
      action.idCurrentUser,
      action.organizedEventsIds,
    ),
  );
}
