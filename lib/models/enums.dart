enum LoadingStatus { none, loading, error, success }

enum EventType {
  event,
  concert,
  festival,
  bar,
  club,
  party,
  houseParty,
  privateParty,
  workshop,
  congress
}

enum EventVisibility { public, follower, following, followerAndFollowing }

enum EventAvailability { available, runningOut, canceled, soldOut }

enum UserVisibility { public, private }

enum Gender { male, female, other, notSpecified }
