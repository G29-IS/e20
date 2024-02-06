import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:redux/redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '/Models/enums.dart';
import '/Models/event.dart';

import '/Redux/App/app_state.dart';
import '/Redux/Events/events_actions.dart';

import '/Services/request_handler.dart';
import '/Utils/console_log.dart';

List<Middleware<AppState>> createEventsMiddleware() {
  return [
    TypedMiddleware<AppState, FetchEventsAction>(_fetchEvents).call,
  ];
}

_fetchEvents(Store<AppState> store, FetchEventsAction action, NextDispatcher next) async {
  store.dispatch(SetEventsLoadingStatusAction(LoadingStatus.loading));
  RequestHandler.fetchFeed().then((rawEvents) {
    IList<Event> parsedEvents = rawEvents.map((element) => Event.fromMap(element)).toIList();

    IMap<String, Event> events = {
      for (var event in parsedEvents) event.idEvent: event,
    }.lock;

    IList<IMap<DateTime, IList<String>>> eventsFeed = [
      (groupBy(parsedEvents, (event) {
        return event.openingDateTime
            .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
      }).map((key, value) => MapEntry(key, value.map((e) => e.idEvent).toIList()))).toIMap()
    ].lock;

    store.dispatch(AddEventsToStateAction(events));
    store.dispatch(AddEventsIdsToFeedAction(eventsFeed));

    store.dispatch(SetEventsLoadingStatusAction(LoadingStatus.success));
  });
}
