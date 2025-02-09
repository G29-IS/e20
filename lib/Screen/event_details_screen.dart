import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';

import '/Models/enums.dart';

import '/Redux/store.dart';
import '/Redux/App/app_state.dart';
import '/Redux/selectors.dart';
import '/Redux/ViewModels/eventVM.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? idEvent = GoRouterState.of(context).pathParameters['idEvent'];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      body: idEvent == null
          ? Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'An error occurred while loading event details! Please try again',
                      style: TextStyle(color: Colors.red, fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 22),
                  ElevatedButton(
                    child: const Icon(Icons.clear),
                    onPressed: () => GoRouter.of(context).go('/home'),
                  ),
                ],
              ),
            )
          : StoreConnector<AppState, EventViewModel>(
              converter: (store) => EventViewModel.create(store, idEvent!),
              builder: (context, vm) => CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    expandedHeight: 300,
                    toolbarHeight: 46,
                    leadingWidth: 62,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          backgroundColor: MaterialStateProperty.all(Colors.white38),
                        ),
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      expandedTitleScale: 1.5,
                      collapseMode: CollapseMode.parallax,
                      title: Text(
                        vm.event.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      titlePadding: const EdgeInsets.only(left: 0.0, bottom: 16.0, right: 0.0),
                      background: Image.network(
                        vm.event.coverImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          DateFormat('EEE d MMM, HH:mm').format(vm.event.openingDateTime),
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          'Location: ${vm.event.place.name ?? vm.event.place.address}\n ${vm.event.place.name == null ? vm.event.place.address : ''}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              "Type: ${vm.event.type.name}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            buildAvailabilityChip(vm.event.availability),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Divider(
                          color: Color.fromARGB(255, 165, 161, 161),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Text(
                          "Organizer:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context).push('/user/${vm.event.idOrganizer}');
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green[900]?.withOpacity(0.1)),
                          ),
                          child: IntrinsicWidth(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                userSel(store, vm.event.idOrganizer)?.profileImageUrl == null
                                    ? const Icon(
                                        Icons.account_circle,
                                        color: Colors.white,
                                        size: 32,
                                      )
                                    : CircleAvatar(
                                        radius: 16,
                                        backgroundImage: NetworkImage(
                                          userSel(store, vm.event.idOrganizer)!.profileImageUrl,
                                        ),
                                        onBackgroundImageError: (exception, stackTrace) =>
                                            const Icon(
                                          Icons.account_circle,
                                          color: Colors.yellow,
                                          size: 32,
                                        ),
                                      ),
                                const SizedBox(width: 10),
                                Text(
                                  userSel(store, vm.event.idOrganizer)?.username ?? 'Unknown',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Divider(
                          color: Color.fromARGB(255, 165, 161, 161),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Text(
                          "Event Info",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          vm.event.description,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 200),
                    ]),
                  ),
                ],
              ),
            ),
    );
  }
}

Widget buildAvailabilityChip(EventAvailability availability) {
  Color color;
  IconData icon;
  switch (availability) {
    case EventAvailability.AVAILABLE:
      icon = Icons.check_circle_outline;
      color = Colors.green;
      break;
    case EventAvailability.RUNNING_OUT:
      icon = Icons.warning_amber_outlined;
      color = Colors.orange;
      break;
    case EventAvailability.CANCELED:
      icon = Icons.cancel_outlined;
      color = Colors.red;
      break;
    case EventAvailability.SOLD_OUT:
      icon = Icons.cancel_outlined;
      color = Colors.grey;
      break;
  }

  return Container(
    height: 36,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withOpacity(0.7)],
        stops: const [0, 0.7],
      ),
      border: Border.all(color: color, width: 2),
      borderRadius: BorderRadius.circular(32),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            availability.name,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(width: 6),
        ],
      ),
    ),
  );
}
