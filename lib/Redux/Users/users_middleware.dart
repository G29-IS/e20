import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:redux/redux.dart';

import '/Models/enums.dart';
import '/Models/event.dart';
import '/Models/user.dart';

import '/Redux/App/app_state.dart';
import '/Redux/Events/events_actions.dart';
import '/Redux/Users/users_actions.dart';

import '/Services/request_handler.dart';
import '/Utils/console_log.dart';

List<Middleware<AppState>> createUsersMiddleware() {
  return [
    TypedMiddleware<AppState, FetchUserAction>(_fetchUser),
  ];
}

_fetchUser(Store<AppState> store, FetchUserAction action, NextDispatcher next) async {
  logWarning("[MIDDLEWARE _fetchUser]: ${action.idUser}");

  store.dispatch(SetUsersLoadingStatusAction(LoadingStatus.loading));
  RequestHandler.fetchUser(idUser: action.idUser).then((value) {
    logSuccess("[MIDDLEWARE _fetchCurrentUser]: $value");
    IList<String>? eventsOrganizedIds = value['eventsOrganized'] != null
        ? (value['eventsOrganized'] as List<dynamic>)
            .map(
              (e) => (e as Map<String, dynamic>)['idEvent'] as String,
            )
            .toList()
            .lock
        : null;

    logWarning("eventsOrganizedIds: $eventsOrganizedIds");

    logWarning("[_fetchUser] eventsOrganized: ${value['eventsOrganized']}");

    User user = User.fromMap(value['user']);
    store.dispatch(
      SaveUserAction(
        idUser: user.idUser,
        user: user,
        organizedEventsIds: eventsOrganizedIds ?? IList(),
      ),
    );

    if (value['eventsOrganized'] != null) {
      store.dispatch(AddEventsToStateAction(
        IMap.fromEntries(
          (value['eventsOrganized'] as List<dynamic>).map(
            (e) => MapEntry(
              (e as Map<String, dynamic>)['idEvent'] as String,
              Event.fromMap(e),
            ),
          ),
        ),
      ));
    }
    store.dispatch(SetUsersLoadingStatusAction(LoadingStatus.success));
  }).catchError((error) {
    logError("[MIDDLEWARE _fetchCurrentUser] RequestHandler.fetchUser: $error");
    store.dispatch(SetUsersLoadingStatusAction(LoadingStatus.error));
  });
}
