import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

import '/Models/enums.dart';
import '/Redux/App/app_state.dart';
import '/Redux/Events/events_actions.dart';
import '/Redux/ViewModels/homeVM.dart';
import '/Utils/console_log.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleCallbackEvent(ScrollDirection direction, ScrollSuccess success, {int? currentIndex}) {
    logWarning(
        "Scroll callback received with data: {direction: $direction, success: $success and index: ${currentIndex ?? 'not given'}}");
  }

  @override
  Widget build(BuildContext context) {
    final Controller controller = Controller()
      ..addListener((event) {
        _handleCallbackEvent(event.direction, event.success);
      });

    late List<StoryController> storyControllers;

    return StoreConnector<AppState, HomeViewModel>(
      onInit: (store) {
        store.dispatch(FetchEventsAction());
      },
      converter: (store) => HomeViewModel.create(store),
      builder: (context, vm) {
        return Scaffold(
            backgroundColor: const Color.fromARGB(255, 34, 34, 34),
            extendBody: true,
            body: Builder(builder: (context) {
              switch (vm.loadingStatus) {
                case LoadingStatus.success:
                  storyControllers = List.generate(vm.feed.length, (index) => StoryController());

                  return Scaffold(
                    backgroundColor: const Color.fromARGB(255, 34, 34, 34),
                    body: TikTokStyleFullPageScroller(
                      contentSize: vm.feed.length,
                      swipePositionThreshold: 0.2,
                      // ^ the fraction of the screen needed to scroll
                      swipeVelocityThreshold: 2000,
                      // ^ the velocity threshold for smaller scrolls
                      animationDuration: const Duration(milliseconds: 400),
                      // ^ how long the animation will take
                      controller: controller,
                      // ^ registering our own function to listen to page changes

                      builder: (BuildContext context, int index) {
                        if (vm.feed.isEmpty) {
                          return const Center(
                              child: Text('No events available',
                                  style: TextStyle(color: Colors.white)));
                        } else {
                          return SafeArea(
                            top: true,
                            bottom: true,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// DATE
                                Container(
                                  padding: const EdgeInsets.only(left: 22, right: 22, top: 22),
                                  child: Text(
                                    DateFormat('EEE dd MMM yy').format(vm.feed[index].keys.first),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                /// CARD
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(22),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: StoryView(
                                      controller: storyControllers[index],
                                      progressPosition: ProgressPosition.top,
                                      repeat: true,
                                      inline: true,
                                      onStoryShow: (s) {
                                        logWarning("Showing a story");
                                      },
                                      onComplete: () {
                                        logWarning("Completed a cycle");
                                      },
                                      storyItems: vm.feed[index].values.first
                                          .map(
                                            (event) => StoryItem(
                                              Stack(
                                                children: [
                                                  // TextButton(
                                                  //     onPressed: () {}, child: Text("test")),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          event.coverImageUrl,
                                                        ),
                                                        fit: BoxFit.cover,
                                                        colorFilter: ColorFilter.mode(
                                                          Colors.black.withOpacity(0.2),
                                                          BlendMode.darken,
                                                        ),
                                                      ),
                                                      color: Colors.grey[850],
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: FractionalOffset.topCenter,
                                                        end: FractionalOffset.bottomCenter,
                                                        colors: [
                                                          Colors.black.withOpacity(0.6),
                                                          Colors.black.withOpacity(0.1),
                                                          Colors.black.withOpacity(0.1),
                                                          Colors.black.withOpacity(0.8),
                                                        ],
                                                        stops: const [0.1, 0.2, 0.6, 0.7],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(22.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                          children: [
                                                            const Icon(
                                                              Icons.account_circle,
                                                              color: Colors.white,
                                                              size: 32,
                                                            ),
                                                            const SizedBox(width: 8),
                                                            SizedBox(
                                                              width: MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  0.6,
                                                              child: Text(
                                                                // TODO: put name of organizer here
                                                                event.idOrganizer,
                                                                style: const TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.normal,
                                                                ),
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          event.name,
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          '${DateFormat('HH:MM').format(event.openingDateTime)} - ${event.place.name ?? event.place.address}',
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.normal,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        ElevatedButton(
                                                          autofocus: true,
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: Colors.white12,
                                                            foregroundColor: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(10),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            context.push('/event/${event.idEvent}');
                                                            logSuccess(
                                                                "Opening event details for ${event.idEvent}");
                                                          },
                                                          onLongPress: () {
                                                            context.push('/event/${event.idEvent}');
                                                            logSuccess(
                                                                "Opening event details for ${event.idEvent}");
                                                          },
                                                          child: const Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('Long press to see details'),
                                                              SizedBox(width: 8),
                                                              Icon(Icons.arrow_forward),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              duration: const Duration(seconds: 3),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  );

                case LoadingStatus.loading:
                  return Center(child: CircularProgressIndicator());

                case LoadingStatus.error:
                default:
                  return Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: Text(
                            'An error occurred while fetching events! Please try again',
                            style: TextStyle(color: Colors.red, fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 22),
                        ElevatedButton(
                          child: const Icon(Icons.refresh),
                          onPressed: () {
                            vm.getFeed();
                          },
                        ),
                      ],
                    ),
                  );
              }
            }));
      },
    );
  }
}
