import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '/Models/enums.dart';
import '/Models/user.dart';

class SetUsersLoadingStatusAction {
  final LoadingStatus loadingStatus;
  SetUsersLoadingStatusAction(this.loadingStatus);
}

class FetchUserAction {
  final String idUser;
  FetchUserAction(this.idUser);
}

class SaveUserAction {
  final String idUser;
  final User user;
  final IList<String> organizedEventsIds;
  SaveUserAction({
    required this.idUser,
    required this.user,
    required this.organizedEventsIds,
  });
}

class SetCurrentUserOrganizedEventsIdsAction {
  final String idCurrentUser;
  final IList<String> organizedEventsIds;
  SetCurrentUserOrganizedEventsIdsAction(this.idCurrentUser, this.organizedEventsIds);
}