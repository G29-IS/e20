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

///
///
/// USER STATE

User? currentUserSel(Store<AppState> store) => store.state.authState.currentUser;

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
    final result = <IMap<DateTime, IList<Event>>>[];
    for (final day in eventsFeed) {
      final date = day.keys.first;
      final ids = day.get(date)!; // Assumption: if there's a date, there's at least one id.
      final eventsForDay = ids.map((id) => events[id]!).toIList();
      result.add(IMap({date: eventsForDay}));
    }
    return IList(result);
  },
);
