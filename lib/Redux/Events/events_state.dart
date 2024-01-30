import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '/Models/enums.dart';
import '/Models/event.dart';

@immutable
class EventsState {
  ///
  /// DATA

  /// List of events ids ordered from closest to furthest date, grouped by date.
  /// Structure IList<IMap(dateTime, IList<idEvent>)>
  final IList<IMap<DateTime, IList<String>>> eventsFeed;

  /// Data structure for storing events.
  /// Structure IMamp<idEvent, Event>
  final IMap<String, Event> events;

  ///
  /// STATE

  /// Loading status of the events feed.
  final LoadingStatus feedLoadingStatus;

  const EventsState({
    required this.eventsFeed,
    required this.events,
    required this.feedLoadingStatus,
  });

  factory EventsState.initial() {
    return EventsState(
      eventsFeed: IList(),
      events: IMap(),
      feedLoadingStatus: LoadingStatus.none,
    );
  }

  EventsState copyWith({
    IList<IMap<DateTime, IList<String>>>? eventsFeed,
    IMap<String, Event>? events,
    LoadingStatus? feedLoadingStatus,
  }) {
    return EventsState(
      eventsFeed: eventsFeed ?? this.eventsFeed,
      events: events ?? this.events,
      feedLoadingStatus: feedLoadingStatus ?? this.feedLoadingStatus,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      'eventsFeed': eventsFeed.toJson((p0) => p0.toJson((p0) => p0, (p0) => p0.toJson((p0) => p0)))
    });
    result.addAll({'events': events.toJson((p0) => p0, (p0) => p0.toMap())});
    result.addAll({'feedLoadingStatus': feedLoadingStatus.name});

    return result;
  }

  factory EventsState.fromMap(Map<String, dynamic> map) {
    return EventsState(
      eventsFeed: IList<IMap<DateTime, IList<String>>>.fromJson(
        json,
        (p0) => p0 as IMap<DateTime, IList<String>>,
      ),
      events: IMap<String, Event>.fromEntries(map['events']),
      feedLoadingStatus: LoadingStatus.values.byName(map['feedLoadingStatus']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventsState.fromJson(String source) => EventsState.fromMap(json.decode(source));

  @override
  String toString() =>
      'EventsState(eventsFeed: $eventsFeed, events: $events, feedLoadingStatus: $feedLoadingStatus)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventsState &&
        other.eventsFeed == eventsFeed &&
        other.events == events &&
        other.feedLoadingStatus == feedLoadingStatus;
  }

  @override
  int get hashCode => eventsFeed.hashCode ^ events.hashCode ^ feedLoadingStatus.hashCode;
}
