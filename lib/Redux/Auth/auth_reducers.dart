import 'package:e20/Redux/Auth/auth_actions.dart';
import 'package:e20/Redux/Auth/auth_state.dart';
import 'package:redux/redux.dart';

final authReducers = combineReducers<AuthState>([
  TypedReducer<AuthState, SetAuthLoadingStatusAction>(_setAuthLoadingStatus),
  TypedReducer<AuthState, SetCurrentUserAction>(_setCurrentUser),
]);

AuthState _setAuthLoadingStatus(AuthState state, SetAuthLoadingStatusAction action) {
  return state.copyWith(authLoadingStatus: action.loadingStatus);
}

AuthState _setCurrentUser(AuthState state, SetCurrentUserAction action) {
  return state.copyWithNullStrict(authToken: action.token, currentUser: action.currentUser);
}
