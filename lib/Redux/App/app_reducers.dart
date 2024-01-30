import '/Redux/App/app_state.dart';
import '/Redux/Events/events_reducers.dart';
import '/Redux/Users/users_reducers.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    eventsState: eventsReducer(state.eventsState, action),
    usersState: usersReducer(state.usersState, action),
  );
}
