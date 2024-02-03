import 'dart:convert';

import 'package:e20/Redux/Auth/auth_state.dart';
import 'package:flutter/foundation.dart' show immutable;

import '/Redux/Events/events_state.dart';
import '/Redux/Users/users_state.dart';

@immutable
class AppState {
  final AuthState authState;
  final EventsState eventsState;
  final UsersState usersState;

  const AppState({
    required this.authState,
    required this.eventsState,
    required this.usersState,
  });

  factory AppState.initial() {
    return AppState(
      // TODO: Fetch previously authed user from some storage? Oppure si salva tutto l'app state direttamente?
      authState: AuthState.initial(), 
      eventsState: EventsState.initial(),
      usersState: UsersState.initial(),
    );
  }

  AppState copyWith({
    AuthState? authState,
    EventsState? eventsState,
    UsersState? usersState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      eventsState: eventsState ?? this.eventsState,
      usersState: usersState ?? this.usersState,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'authState': authState.toMap()});
    result.addAll({'eventsState': eventsState.toMap()});
    result.addAll({'usersState': usersState.toMap()});

    return result;
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(
      authState: AuthState.fromMap(map['authState']),
      eventsState: EventsState.fromMap(map['eventsState']),
      usersState: UsersState.fromMap(map['usersState']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppState.fromJson(String source) => AppState.fromMap(json.decode(source));

  @override
  String toString() => 'AppState(authState: $authState, eventsState: $eventsState, usersState: $usersState)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppState && other.authState == authState && other.eventsState == eventsState && other.usersState == usersState;
  }

  @override
  int get hashCode => authState.hashCode ^ eventsState.hashCode ^ usersState.hashCode;
}
