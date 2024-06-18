// ignore_for_file: constant_identifier_names

enum LoadingStatus { none, loading, error, success }

enum EventType {
  EVENT,
  CONCERT,
  FESTIVAL,
  BAR,
  CLUB,
  PARTY,
  HOUSEPARTY,
  PRIVATEPARTY,
  WORKSHOP,
  CONGRESS
}

enum EventVisibility { PUBLIC, FOLLOWER, FOLLOWING, FOLLOWER_AND_FOLLOWING }

enum EventAvailability { AVAILABLE, RUNNING_OUT, CANCELED, SOLD_OUT }

enum UserVisibility { PUBLIC, PRIVATE }

enum Gender { MALE, FEMALE, OTHER, NOT_SPECIFIED }
