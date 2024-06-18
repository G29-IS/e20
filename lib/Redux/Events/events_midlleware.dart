import 'package:redux/redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';

import '/Models/enums.dart';
import '/Models/event.dart';
import '/Models/user.dart';

import '/Redux/App/app_state.dart';
import '/Redux/selectors.dart';
import '/Redux/Events/events_actions.dart';
import '/Redux/Users/users_actions.dart';
import '/Redux/Auth/auth_actions.dart';

import '/Services/request_handler.dart';
import '/Utils/console_log.dart';

List<Middleware<AppState>> createEventsMiddleware() {
  return [
    TypedMiddleware<AppState, FetchEventsAction>(_fetchEvents),
    TypedMiddleware<AppState, CreateNewEventAction>(_createNewEvent),
    TypedMiddleware<AppState, DeleteEventAction>(_deleteEvent),
  ];
}

_createNewEvent(Store<AppState> store, CreateNewEventAction action, NextDispatcher next) async {
  store.dispatch(SetEventsLoadingStatusAction(LoadingStatus.loading));
  logWarning("[MIDDLEWARE _createNewEvent] action.event: ${action.event}");
  RequestHandler.createNewEvent(action.event, tokenSel(store)!).then((value) {
    store.dispatch(SetEventsLoadingStatusAction(LoadingStatus.success));
    store.dispatch(FetchCurrentUserAction()); // Update the user's events
    GoRouter.of(action.context).go('/profile');
  }).catchError((error) {
    logError("[MIDDLEWARE _createNewEvent] RequestHandler.createNewEvent: $error");
    store.dispatch(SetEventsLoadingStatusAction(LoadingStatus.error));
  });
}

_deleteEvent(Store<AppState> store, DeleteEventAction action, NextDispatcher next) async {
  RequestHandler.deleteEvent(action.idEvent, tokenSel(store)!).then((value) {
    next(action);
    store.dispatch(DeleteEventOrganizedByCurrentUserAction(action.idEvent));
  }).catchError((error) {
    logError("[MIDDLEWARE _deleteEvent] RequestHandler.deleteEvent: $error");
  });
}

_fetchEvents(Store<AppState> store, FetchEventsAction action, NextDispatcher next) async {
  store.dispatch(SetEventsLoadingStatusAction(LoadingStatus.loading));
  RequestHandler.fetchFeed().then(
    (data) {
      logSuccess("[MIDDLEWARE _fetchEvents] RequestHandler.fetchFeed: $data");
      IList<Event> parsedEvents =
          (data['events']! as List<dynamic>).map((element) => Event.fromMap(element)).toIList();
      IList<User> parsedUsers =
          (data['users']! as List<dynamic>).map((element) => User.fromMap(element)).toIList();
      logWarning("parsedUsers: $parsedUsers");

      IMap<String, Event> events = {
        for (var event in parsedEvents) event.idEvent: event,
      }.lock;

      IMap<String, User> users = {
        for (var user in parsedUsers) user.idUser: user,
      }.lock;

      IList<IMap<DateTime, IList<String>>> eventsFeed = [
        (groupBy(parsedEvents, (event) {
          return event.openingDateTime
              .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
        }).map((key, value) => MapEntry(key, value.map((e) => e.idEvent).toIList()))).toIMap()
      ].lock;

      // Extract and sort the entries by DateTime
      final sortedEntries = eventsFeed.first.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));

      // Rebuild the IMap with the sorted entries
      final sortedIMap = IMap.fromEntries(sortedEntries);

      // Update the eventsFeed with the sorted IMap
      eventsFeed = [sortedIMap].lock;

      logSuccess("eventsFeed SORTED: $eventsFeed");

      store.dispatch(AddEventsToStateAction(events));
      store.dispatch(AddEventsIdsToFeedAction(eventsFeed));

      store.dispatch(AddUsersToStateAction(users));

      store.dispatch(SetEventsLoadingStatusAction(LoadingStatus.success));
    },
  ).onError(
    (error, stackTrace) {
      logError("[MIDDLEWARE _fetchEvents] RequestHandler.fetchFeed: $error");
      store.dispatch(SetEventsLoadingStatusAction(LoadingStatus.error));
    },
  );

  /*store.dispatch(SetEventsLoadingStatusAction(LoadingStatus.loading));

  Future.delayed(
    const Duration(seconds: 2),
  );

  /// PARSING
  IMap<String, Event> events = Map<String, Event>.from({
    ///DUMMY DATA
    'idev_1': Event(
      idEvent: 'idev_1',
      name: '2024 Baby',
      coverImageUrl:
          "https://images.unsplash.com/photo-1704168370831-b7f450dadeb0?q=80&w=3687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      idOrganizer: 'idorg_1',
      description: String.fromCharCodes(
        Iterable.generate(100, (_) => 65 + Random().nextInt(26)),
      ),
      doorOpeningDateTime: DateTime.now().add(const Duration(days: 1)),
      openingDateTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
      type: EventType.event,
      visibility: EventVisibility.public,
      availability: EventAvailability.available,
      place: const EventPlace(
        name: 'Piazza Duomo',
        address: 'Piazza Duomo, Trento',
      ),
    ),
    'idev_2': Event(
      idEvent: 'idev_2',
      name: 'Concerto',
      coverImageUrl:
          "https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?q=80&w=3870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      idOrganizer: 'idorg_2',
      description: String.fromCharCodes(
        Iterable.generate(100, (_) => 65 + Random().nextInt(26)),
      ),
      doorOpeningDateTime: DateTime.now().add(const Duration(days: 1)),
      openingDateTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
      type: EventType.concert,
      visibility: EventVisibility.public,
      maxParticipants: 1500,
      paymentLink:
          "https://www.trento.info/dettaglio-evento/-/c/n/mercatino-di-natale-di-trento_a88d6e1b-8e03-5598-a1b9-0ea7c526b311",
      availability: EventAvailability.running_out,
      place: const EventPlace(
        name: 'Piazza Fiera',
        address: 'Piazza Fiera, Trento',
      ),
    ),
    'idev_3': Event(
      idEvent: 'idev_3',
      name: 'AperiTrento',
      coverImageUrl:
          "https://images.unsplash.com/photo-1654171567840-58c77ee342d9?q=80&w=3610&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      idOrganizer: 'idorg_2',
      description: String.fromCharCodes(
        Iterable.generate(100, (_) => 65 + Random().nextInt(26)),
      ),
      doorOpeningDateTime: DateTime.now().add(const Duration(days: 2, hours: 4)),
      openingDateTime: DateTime.now().add(const Duration(days: 2, hours: 5)),
      type: EventType.bar,
      visibility: EventVisibility.public,
      availability: EventAvailability.running_out,
      place: const EventPlace(
        name: 'Baccus',
        address: 'Piazza Fiera, 11 Trento',
      ),
    ),
  }).toIMap();

  IList<IMap<DateTime, IList<String>>> eventsFeed = List<IMap<DateTime, IList<String>>>.from([
    Map<DateTime, IList<String>>.from({
      DateTime.now().add(const Duration(days: 1)): ['idev_1', 'idev_2'].lock,
    }).toIMap(),
    Map<DateTime, IList<String>>.from({
      DateTime.now().add(const Duration(days: 2)): ['idev_3'].lock,
    }).toIMap(),
  ]).toIList();

  store.dispatch(AddEventsToStateAction(events));
  store.dispatch(AddEventsIdsToFeedAction(eventsFeed));

  store.dispatch(SetEventsLoadingStatusAction(LoadingStatus.success));*/
}
