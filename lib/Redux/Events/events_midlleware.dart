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

    IMap<String, Event> events = {for (var event in parsedEvents) event.idEvent: event}.lock;

    IList<IMap<DateTime, IList<String>>> eventsFeed = [
      (groupBy(parsedEvents, (event) {
        return event.openingDateTime.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
      }).map((key, value) => MapEntry(key, value.map((e) => e.idEvent).toIList()))).toIMap()
    ].lock;

    store.dispatch(AddEventsToStateAction(events));
    store.dispatch(AddEventsIdsToFeedAction(eventsFeed));

    store.dispatch(SetEventsLoadingStatusAction(LoadingStatus.success));
  }).catchError((error) {
    logError(error);
    store.dispatch(SetEventsLoadingStatusAction(LoadingStatus.error));
  });

  // Future.delayed(
  //   const Duration(seconds: 2),
  // );

  // /// PARSING
  // IMap<String, Event> events = Map<String, Event>.from({
  //   ///DUMMY DATA
  //   'idev_1': Event(
  //     idEvent: 'idev_1',
  //     name: '2024 Baby',
  //     coverImageUrl:
  //         "https://images.unsplash.com/photo-1704168370831-b7f450dadeb0?q=80&w=3687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  //     idOrganizer: 'idorg_1',
  //     description: String.fromCharCodes(
  //       Iterable.generate(100, (_) => 65 + Random().nextInt(26)),
  //     ),
  //     placeName: 'Piazza Duomo',
  //     placeAddress: 'Piazza Duomo, Trento',
  //     doorOpeningDateTime: DateTime.now().add(const Duration(days: 1)),
  //     openingDateTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
  //     type: EventType.event,
  //     visibility: EventVisibility.public,
  //     availability: EventAvailability.available,
  //   ),
  //   'idev_2': Event(
  //     idEvent: 'idev_2',
  //     name: 'Concerto',
  //     coverImageUrl:
  //         "https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?q=80&w=3870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  //     idOrganizer: 'idorg_2',
  //     description: String.fromCharCodes(
  //       Iterable.generate(100, (_) => 65 + Random().nextInt(26)),
  //     ),
  //     placeName: 'Piazza Fiera, Trento',
  //     placeAddress: 'Piazza Fiera, Trento',
  //     doorOpeningDateTime: DateTime.now().add(const Duration(days: 1)),
  //     openingDateTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
  //     type: EventType.concert,
  //     visibility: EventVisibility.public,
  //     maxPartecipants: 1500,
  //     paymentLink:
  //         "https://www.trento.info/dettaglio-evento/-/c/n/mercatino-di-natale-di-trento_a88d6e1b-8e03-5598-a1b9-0ea7c526b311",
  //     availability: EventAvailability.runningOut,
  //   ),
  //   'idev_3': Event(
  //     idEvent: 'idev_3',
  //     name: 'AperiTrento',
  //     coverImageUrl:
  //         "https://images.unsplash.com/photo-1654171567840-58c77ee342d9?q=80&w=3610&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  //     idOrganizer: 'idorg_2',
  //     description: String.fromCharCodes(
  //       Iterable.generate(100, (_) => 65 + Random().nextInt(26)),
  //     ),
  //     placeName: 'Baccus',
  //     placeAddress: 'Piazza Fiera, 11 Trento',
  //     doorOpeningDateTime: DateTime.now().add(const Duration(days: 2, hours: 4)),
  //     openingDateTime: DateTime.now().add(const Duration(days: 2, hours: 5)),
  //     type: EventType.bar,
  //     visibility: EventVisibility.public,
  //     availability: EventAvailability.runningOut,
  //   ),
  // }).toIMap();

  // IList<IMap<DateTime, IList<String>>> eventsFeed = List<IMap<DateTime, IList<String>>>.from([
  //   Map<DateTime, IList<String>>.from({
  //     DateTime.now().add(const Duration(days: 1)): ['idev_1', 'idev_2'].lock,
  //   }).toIMap(),
  //   Map<DateTime, IList<String>>.from({
  //     DateTime.now().add(const Duration(days: 2)): ['idev_3'].lock,
  //   }).toIMap(),
  // ]).toIList();

  // store.dispatch(AddEventsToStateAction(events));
  // store.dispatch(AddEventsIdsToFeedAction(eventsFeed));

  // store.dispatch(SetEventsLoadingStatusAction(LoadingStatus.success));
}
