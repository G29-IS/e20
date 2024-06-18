import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';

import '/Models/event.dart';

import '/Redux/App/app_state.dart';
import '/Redux/selectors.dart';

import '/Utils/console_log.dart';

@immutable
class EventViewModel {
  final String idEvent;

  final Event event;

  const EventViewModel({
    required this.idEvent,
    required this.event,
  });

  factory EventViewModel.create(Store<AppState> store, String idEvent) {
    logWarning("EventViewModel.create(store) called: $idEvent");

    return EventViewModel(
      idEvent: idEvent,
      event: eventSel(store, idEvent)!,
    );
  }
}
