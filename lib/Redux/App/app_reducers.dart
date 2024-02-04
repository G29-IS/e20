import 'package:e20/Redux/Auth/auth_reducers.dart';

import '/Redux/App/app_state.dart';
import '/Redux/Events/events_reducers.dart';
import '/Redux/Users/users_reducers.dart';

AppState appReducers(AppState state, action) {
  return AppState(
    authState: authReducers(state.authState, action),
    eventsState: eventsReducer(state.eventsState, action),
    usersState: usersReducer(state.usersState, action),
  );
}
