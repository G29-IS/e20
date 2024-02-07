import 'package:flutter/foundation.dart' show immutable;
import 'package:redux/redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '/Models/enums.dart';
import '/Models/event.dart';

import '/Redux/App/app_state.dart';
import '/Redux/selectors.dart';
import '/Redux/Events/events_actions.dart';

@immutable
class HomeViewModel {
  final LoadingStatus loadingStatus;
  final IList<IMap<DateTime, IList<Event>>> feed;

  final Function() getFeed;

  const HomeViewModel({
    required this.loadingStatus,
    required this.feed,
    required this.getFeed,
  });

  factory HomeViewModel.create(Store<AppState> store) {
    getFeed() {
      store.dispatch(FetchEventsAction());
    }

    return HomeViewModel(
      loadingStatus: eventsLoadingStatusSel(store),
      feed: eventsFeedMemoizedSel(store),
      getFeed: getFeed,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeViewModel &&
          other.loadingStatus == loadingStatus &&
          other.feed == feed &&
          other.getFeed == getFeed;

  @override
  int get hashCode => loadingStatus.hashCode ^ feed.hashCode ^ getFeed.hashCode;
}
