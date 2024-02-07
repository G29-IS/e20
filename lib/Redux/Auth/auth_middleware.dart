import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';

import '/Models/enums.dart';
import '/Models/user.dart';
import '/Models/event.dart';

import '/Redux/selectors.dart';
import '/Redux/App/app_state.dart';
import '/Redux/Auth/auth_actions.dart';
import '/Redux/Users/users_actions.dart';
import '/Redux/Events/events_actions.dart';

import '/Services/request_handler.dart';
import '/Utils/console_log.dart';

List<Middleware<AppState>> createAuthMiddleware() {
  return [
    TypedMiddleware<AppState, LoginAction>(_login),
    TypedMiddleware<AppState, FetchCurrentUserAction>(_fetchCurrentUser),
  ];
}

_login(Store<AppState> store, LoginAction action, NextDispatcher next) async {
  store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.loading));
  RequestHandler.login(action.email, action.password).then((value) {
    store.dispatch(SetAuthTokenAction(value));
    store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.success));
  }).catchError((error) {
    logError("[MIDDLEWARE _login] RequestHandler.login: $error");
    store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.error));
  });
}

_loginWithGoogle(Store<AppState> store, LoginAction action, NextDispatcher next) async {
  store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.loading));

  // try {
  //   final _googleSignIn = GoogleSignIn(
  //     clientId: '440766959100-cv6jcj6r9upc7gho5tj9v0d7nclkpaj9.apps.googleusercontent.com',
  //     scopes: ['email'],
  //   );

  //   RequestHandler.login(action.email, action.password).then((value) {
  //     store.dispatch(SetAuthTokenAction(value));
  //     store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.success));
  //   }).catchError((error) {
  //     logError("[MIDDLEWARE _login] RequestHandler.login: $error");
  //     store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.error));
  //   });
  // } catch (error) {
  //   logError("[MIDDLEWARE _login] RequestHandler.login: $error");
  //   store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.error));
  // }

  // RequestHandler.login(action.email, action.password).then((value) {
  //   store.dispatch(SetAuthTokenAction(value));
  //   store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.success));
  // }).catchError((error) {
  //   logError("[MIDDLEWARE _login] RequestHandler.login: $error");
  //   store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.error));
  // });
}

_logout(Store<AppState> store, LogoutAction action, NextDispatcher next) {
  store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.loading));

  RequestHandler.logout().then((_) {
    store.dispatch(RemoveAuthTokenAction());
    store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.success));
  }).catchError((error) {
    logError("[MIDDLEWARE _logout] RequestHandler.logout: $error");
    store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.error));
  });
}

_fetchCurrentUser(Store<AppState> store, FetchCurrentUserAction action, NextDispatcher next) async {
  store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.loading));

  RequestHandler.fetchCurrentUser(tokenSel(store)).then((user) {
    store.dispatch(SetCurrentUserAction(user));

    RequestHandler.fetchUser(idUser: user.idUser).then((value) {
      logSuccess("[MIDDLEWARE _fetchCurrentUser]: $value");
      IList<String> eventsOrganizedIds = (value['eventsOrganized'] as List<dynamic>)
          .map(
            (e) => (e as Map<String, dynamic>)['idEvent'] as String,
          )
          .toList()
          .lock;
      logWarning("eventsOrganizedIds: $eventsOrganizedIds");

      store.dispatch(
        SetCurrentUserAction(User.fromMap(value['user'])),
      );
      store.dispatch(
        SetCurrentUserOrganizedEventsIdsAction(
          user.idUser,
          eventsOrganizedIds,
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
      store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.success));
    }).catchError((error) {
      logError("[MIDDLEWARE _fetchCurrentUser] RequestHandler.fetchUser: $error");
      store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.error));
    });
  });

  //   },
  // ).catchError((error) {
  //   logError("[MIDDLEWARE _fetchCurrentUser] RequestHandler.fetchCurrentUser: $error");
  //   store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.error));
  // });

  // store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.loading));

  // RequestHandler.fetchCurrentUser(tokenSel(store)).then(
  //   (user) {
  //     store.dispatch(SetCurrentUserAction(user));

  //     // I use this endpoint to fetch the user's organized events
  //     /// TODO: REMOVE AFTER LOGIN IMPLEMENTATION
  //     // RequestHandler.fetchUser(tokenSel(store), idUser: user.idUser)
  //     RequestHandler.fetchUser(tokenSel(store), idUser: "bc9e631a-5e19-4885-ac01-1a3c48ffe9d3")
  //         .then((value) {
  //       logSuccess("[MIDDLEWARE _fetchCurrentUser]: $value");
  //       store.dispatch(
  //         SetCurrentUserOrganizedEventsIdsAction(
  //           user.idUser,
  //           value['eventsOrganized'],
  //         ),
  //       );
  //     }).catchError((error) {
  //       logError("[MIDDLEWARE _fetchCurrentUser] RequestHandler.fetchUser: $error");
  //     });
  //   },
  // ).catchError((error) {
  //   logError("[MIDDLEWARE _fetchCurrentUser] RequestHandler.fetchCurrentUser: $error");
  //   store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.error));
  // });

  // store.dispatch(SetAuthLoadingStatusAction(LoadingStatus.success));
}
