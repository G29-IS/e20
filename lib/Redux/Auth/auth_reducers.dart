import 'package:redux/redux.dart';

import '/Redux/Auth/auth_state.dart';
import '/Redux/Auth/auth_actions.dart';

final authReducers = combineReducers<AuthState>([
  TypedReducer<AuthState, SetAuthLoadingStatusAction>(_setAuthLoadingStatus),
  TypedReducer<AuthState, SetAuthTokenAction>(_setAuthToken),
  TypedReducer<AuthState, RemoveAuthTokenAction>(_removeAuthToken),
  TypedReducer<AuthState, SetCurrentUserAction>(_setCurrentUser),
]);

AuthState _setAuthLoadingStatus(AuthState state, SetAuthLoadingStatusAction action) {
  return state.copyWith(authLoadingStatus: action.loadingStatus);
}

AuthState _setAuthToken(AuthState state, SetAuthTokenAction action) {
  return state.copyWith(authToken: action.authToken);
}

AuthState _removeAuthToken(AuthState state, RemoveAuthTokenAction action) {
  return state.copyWith(authToken: null);
}

AuthState _setCurrentUser(AuthState state, SetCurrentUserAction action) {
  return state.copyWith(currentUser: action.currentUser);
}
