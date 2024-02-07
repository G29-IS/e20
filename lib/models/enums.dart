// ignore_for_file: constant_identifier_names

enum LoadingStatus { none, loading, error, success }

enum EventType {
  event,
  concert,
  festival,
  bar,
  club,
  party,
  houseparty,
  privateparty,
  workshop,
  congress
}

enum EventVisibility { public, follower, following, followerAndFollowing }

enum EventAvailability { available, running_out, canceled, sold_out }

enum UserVisibility { public, private }

enum Gender { male, female, other, not_specified }
