import 'package:flutter/widgets.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '/Models/enums.dart';
import '/Models/event.dart';

class FetchEventsAction {
  FetchEventsAction();
}

class SetEventsLoadingStatusAction {
  final LoadingStatus loadingStatus;
  SetEventsLoadingStatusAction(this.loadingStatus);
}

class AddEventsIdsToFeedAction {
  final IList<IMap<DateTime, IList<String>>> eventsFeed;
  AddEventsIdsToFeedAction(this.eventsFeed);
}

class AddEventsToStateAction {
  final IMap<String, Event> events;
  AddEventsToStateAction(this.events);
}

class CreateNewEventAction {
  final Event event;
  final BuildContext context;
  CreateNewEventAction(this.event, this.context);
}

class DeleteEventAction {
  final String idEvent;
  DeleteEventAction(this.idEvent);
}
