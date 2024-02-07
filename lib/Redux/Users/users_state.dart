import 'dart:convert';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart' show immutable;

import '/Models/enums.dart';
import '/Models/user.dart';

@immutable
class UsersState {
  ///
  /// STATE

  /// Loading status used when fetching user data.
  final LoadingStatus usersLoadingStatus;

  ///
  /// DATA

  /// Data structure for storing users.
  final IMap<String, User> users;

  /// Data structure for storing events ids organized by user.
  /// IMap<idUser, IList<idEvent>>
  final IMap<String, IList<String>> eventsOrganizedByUser;

  const UsersState({
    required this.usersLoadingStatus,
    required this.users,
    required this.eventsOrganizedByUser,
  });

  factory UsersState.initial() {
    return UsersState(
      users: IMap(),
      usersLoadingStatus: LoadingStatus.none,
      eventsOrganizedByUser: IMap(),
    );
  }

  UsersState copyWith({
    LoadingStatus? usersLoadingStatus,
    IMap<String, User>? users,
    IMap<String, IList<String>>? eventsOrganizedByUser,
  }) {
    return UsersState(
      usersLoadingStatus: usersLoadingStatus ?? this.usersLoadingStatus,
      users: users ?? this.users,
      eventsOrganizedByUser: eventsOrganizedByUser ?? this.eventsOrganizedByUser,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'usersLoadingStatus': usersLoadingStatus.name});
    result.addAll({'users': users.toJson((p0) => p0, (p0) => p0.toMap())});
    result.addAll({
      'eventsOrganizedByUser':
          eventsOrganizedByUser.toJson((p0) => p0, (p0) => p0.toJson((p0) => p0))
    });

    return result;
  }

  factory UsersState.fromMap(Map<String, dynamic> map) {
    return UsersState(
      usersLoadingStatus: LoadingStatus.values.byName(map['usersLoadingStatus']),
      users: IMap<String, User>.fromEntries(map['users']),
      eventsOrganizedByUser: IMap<String, IList<String>>.fromEntries(map['eventsOrganizedByUser']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UsersState.fromJson(String source) => UsersState.fromMap(json.decode(source));

  @override
  String toString() =>
      'UsersState(usersLoadingStatus: $usersLoadingStatus, users: $users, eventsOrganizedByUser: $eventsOrganizedByUser)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersState &&
        other.usersLoadingStatus == usersLoadingStatus &&
        other.users == users &&
        other.eventsOrganizedByUser == eventsOrganizedByUser;
  }

  @override
  int get hashCode => usersLoadingStatus.hashCode ^ users.hashCode ^ eventsOrganizedByUser.hashCode;
}
