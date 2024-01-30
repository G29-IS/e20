import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '/Models/user.dart';
import '/Models/enums.dart';

@immutable
class UsersState {
  ///
  /// DATA

  /// Data structure for storing users.
  final IMap<String, User> users;

  ///
  /// STATE

  /// Loading status used when fetching user data.
  final LoadingStatus usersLoadingStatus;

  const UsersState({
    required this.users,
    required this.usersLoadingStatus,
  });

  factory UsersState.initial() {
    return UsersState(
      users: IMap(),
      usersLoadingStatus: LoadingStatus.none,
    );
  }

  UsersState copyWith({
    IMap<String, User>? users,
    LoadingStatus? usersLoadingStatus,
  }) {
    return UsersState(
      users: users ?? this.users,
      usersLoadingStatus: usersLoadingStatus ?? this.usersLoadingStatus,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'users': users.toJson((k) => k, (v) => v.toJson())});
    result.addAll({'usersLoadingStatus': usersLoadingStatus.name});
    return result;
  }

  factory UsersState.fromMap(Map<String, dynamic> map) {
    return UsersState(
      users: IMap<String, User>.fromEntries(map['users']),
      usersLoadingStatus: LoadingStatus.values.byName(map['usersLoadingStatus']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UsersState.fromJson(String source) => UsersState.fromMap(json.decode(source));

  @override
  String toString() => 'UsersState(users: $users, usersLoadingStatus: $usersLoadingStatus)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersState &&
        other.users == users &&
        other.usersLoadingStatus == usersLoadingStatus;
  }

  @override
  int get hashCode => users.hashCode ^ usersLoadingStatus.hashCode;
}
