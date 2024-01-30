import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

import '/Redux/Events/events_state.dart';
import '/Redux/Users/users_state.dart';

@immutable
class AppState {
  final EventsState eventsState;
  final UsersState usersState;

  const AppState({
    required this.eventsState,
    required this.usersState,
  });

  factory AppState.initial() {
    return AppState(
      eventsState: EventsState.initial(),
      usersState: UsersState.initial(),
    );
  }

  AppState copyWith({
    EventsState? eventsState,
    UsersState? usersState,
  }) {
    return AppState(
      eventsState: eventsState ?? this.eventsState,
      usersState: usersState ?? this.usersState,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'eventsState': eventsState.toMap()});
    result.addAll({'usersState': usersState.toMap()});

    return result;
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(
      eventsState: EventsState.fromMap(map['eventsState']),
      usersState: UsersState.fromMap(map['usersState']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppState.fromJson(String source) => AppState.fromMap(json.decode(source));

  @override
  String toString() => 'AppState(eventsState: $eventsState, usersState: $usersState)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppState && other.eventsState == eventsState && other.usersState == usersState;
  }

  @override
  int get hashCode => eventsState.hashCode ^ usersState.hashCode;
}
