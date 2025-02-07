import 'package:redux/redux.dart';

import '/Redux/Users/users_state.dart';
import '/Redux/Users/users_actions.dart';

final usersReducers = combineReducers<UsersState>([
  TypedReducer<UsersState, SetUsersLoadingStatusAction>(_setUsersLoadingStatus),
  TypedReducer<UsersState, SaveUserAction>(_saveUser),
  TypedReducer<UsersState, AddUsersToStateAction>(_addUsersToState),
  TypedReducer<UsersState, AddEventsOrganizedByUserAction>(_addEventsOrganizedByUser),
  TypedReducer<UsersState, SetCurrentUserOrganizedEventsIdsAction>(
      _setCurrentUserOrganizedEventsIds),
  TypedReducer<UsersState, DeleteEventOrganizedByCurrentUserAction>(
      _deleteEventOrganizedByCurrentUser),
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

UsersState _addUsersToState(UsersState state, AddUsersToStateAction action) {
  return state.copyWith(users: state.users.addAll(action.users));
}

UsersState _addEventsOrganizedByUser(UsersState state, AddEventsOrganizedByUserAction action) {
  return state.copyWith(
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

UsersState _deleteEventOrganizedByCurrentUser(
    UsersState state, DeleteEventOrganizedByCurrentUserAction action) {
  return state.copyWith(
    eventsOrganizedByUser: state.eventsOrganizedByUser.map(
      (key, value) => MapEntry(
        key,
        value.remove(action.idEvent),
      ),
    ),
  );
}
