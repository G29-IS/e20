import 'package:redux/redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '/Redux/Events/events_actions.dart';
import '/Redux/Events/events_state.dart';

final eventsReducer = combineReducers<EventsState>([
  TypedReducer<EventsState, SetEventsLoadingStatusAction>(_setEventsLoadingStatus),
  TypedReducer<EventsState, AddEventsIdsToFeedAction>(_addEventsIdsToFeed),
  TypedReducer<EventsState, AddEventsToStateAction>(_addEventsToState),
  TypedReducer<EventsState, DeleteEventAction>(_deleteEventAction),
]);

EventsState _setEventsLoadingStatus(EventsState state, SetEventsLoadingStatusAction action) {
  return state.copyWith(feedLoadingStatus: action.loadingStatus);
}

EventsState _addEventsIdsToFeed(EventsState state, AddEventsIdsToFeedAction action) {
  return state.copyWith(eventsFeed: action.eventsFeed);
}

EventsState _addEventsToState(EventsState state, AddEventsToStateAction action) {
  return state.copyWith(events: state.events.addAll(action.events));
}

EventsState _deleteEventAction(EventsState state, DeleteEventAction action) {
  DateTime? day;

  for (var dateMap in state.eventsFeed) {
    dateMap.forEach((date, events) {
      if (events.contains(action.idEvent)) {
        day = date;
      }
    });
  }

  bool isTheOnlyEventOnDay =
      state.eventsFeed.firstWhere((element) => element.keys.first == day).values.first.length == 1;

  if (day != null && isTheOnlyEventOnDay) {
    return state.copyWith(
      events: state.events.remove(action.idEvent),
      eventsFeed: state.eventsFeed
          .map(
            (day) => day.remove(day.keys.first),
          )
          .toList()
          .lock,
    );
  } else if (day != null && !isTheOnlyEventOnDay) {
    return state.copyWith(
      events: state.events.remove(action.idEvent),
      eventsFeed: state.eventsFeed
          .map(
            (day) => day.map((key, value) {
              if (value.contains(action.idEvent)) {
                return MapEntry(key, value.remove(action.idEvent));
              }
              return MapEntry(key, value);
            }),
          )
          .toList()
          .lock,
    );
  } else {
    return state.copyWith(events: state.events.remove(action.idEvent));
  }
}
