import 'package:redux/redux.dart';

import '/Redux/Events/events_actions.dart';
import '/Redux/Events/events_state.dart';

final eventsReducer = combineReducers<EventsState>([
  TypedReducer<EventsState, SetEventsLoadingStatusAction>(_setEventsLoadingStatus),
  TypedReducer<EventsState, AddEventsIdsToFeedAction>(_addEventsIdsToFeed),
  TypedReducer<EventsState, AddEventsToStateAction>(_addEventsToState),
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
