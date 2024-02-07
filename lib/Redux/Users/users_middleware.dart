import 'package:redux/redux.dart';

import '/Redux/App/app_state.dart';
import '/Redux/Users/users_actions.dart';

List<Middleware<AppState>> createUsersMiddleware() {
  return [
    TypedMiddleware<AppState, FetchUserAction>(_fetchUser),
  ];
}

_fetchUser(Store<AppState> store, FetchUserAction action, NextDispatcher next) async {
  next(action);
}
