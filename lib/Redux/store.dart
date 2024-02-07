import 'package:redux/redux.dart';

import '/Redux/Auth/auth_middleware.dart';
import '/Redux/Events/events_midlleware.dart';
import '/Redux/Users/users_middleware.dart';

import 'App/app_state.dart';
import 'App/app_reducers.dart';

final store = Store<AppState>(
  appReducers,
  initialState: AppState.initial(),
  middleware: [
    ...createAuthMiddleware(),
    ...createEventsMiddleware(),
    ...createUsersMiddleware(),
  ],
);
