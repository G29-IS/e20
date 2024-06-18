import 'package:redux/redux.dart';
import 'package:reselect/reselect.dart'; // for memoized selectors
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '/Models/enums.dart';
import '/Models/event.dart';
import '/Models/user.dart';

import '/Redux/App/app_state.dart';

///
///
/// AUTH STATE

String? tokenSel(Store<AppState> store) => store.state.authState.authToken;

LoadingStatus authLoadingStatusSel(Store<AppState> store) =>
    store.state.authState.authLoadingStatus;

User? currentUserSel(Store<AppState> store) => store.state.authState.currentUser;

///
///
/// USER STATE

LoadingStatus usersLoadingStatusSel(Store<AppState> store) =>
    store.state.usersState.usersLoadingStatus;

IList<String> currentUserOrganizedEventsIdsSel(Store<AppState> store) =>
    store.state.authState.currentUser == null
        ? IList()
        : store.state.usersState.eventsOrganizedByUser[store.state.authState.currentUser!.idUser] ??
            IList();

User? userSel(Store<AppState> store, String id) => store.state.usersState.users[id];

IList<String> userOrganizedEventsIdsSel(Store<AppState> store, String idUser) =>
    store.state.usersState.eventsOrganizedByUser[idUser] ?? IList();

///
///
/// EVENTS STATE

LoadingStatus eventsLoadingStatusSel(Store<AppState> store) =>
    store.state.eventsState.feedLoadingStatus;

IMap<String, Event> eventsSel(Store<AppState> store) => store.state.eventsState.events;

Event? eventSel(Store<AppState> store, String id) => store.state.eventsState.events[id];

IList<IMap<DateTime, IList<String>>> eventsFeedSel(Store<AppState> store) =>
    store.state.eventsState.eventsFeed;

final eventsFeedMemoizedSel = createSelector2<Store<AppState>, IMap<String, Event>,
    IList<IMap<DateTime, IList<String>>>, IList<IMap<DateTime, IList<Event>>>>(
  eventsSel,
  eventsFeedSel,
  (events, eventsFeed) {
    IList<IMap<DateTime, IList<Event>>> result = IList();
    for (IMap<DateTime, IList<String>> day in eventsFeed) {
      for (var entry in day.entries) {
        DateTime date = entry.key;
        IList<String> ids = entry.value;
        IList<Event> eventsForDay = ids.map((id) => events[id]!).toIList();
        result = result.add(IMap({date: eventsForDay}));
      }
    }
    return result.flush;
  },
);
