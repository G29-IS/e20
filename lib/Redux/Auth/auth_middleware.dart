import 'package:e20/Redux/App/app_state.dart';
import 'package:e20/Redux/Auth/auth_actions.dart';
import 'package:e20/models/enums.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAuthMiddleware() {
  return [
    TypedMiddleware<AppState, LoginAction>(_login),
  ];
}

_login(Store<AppState> store, LoginAction action, NextDispatcher next) async {
  store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.loading));

  // TODO: Api call with email ausername nd password

  store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.success));
}
