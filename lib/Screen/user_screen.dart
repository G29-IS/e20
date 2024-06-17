import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';

import '/Models/enums.dart';

import '/Redux/store.dart';
import '/Redux/App/app_state.dart';
import '/Redux/selectors.dart';
import '/Redux/Users/users_actions.dart';
import '/Redux/ViewModels/userVM.dart';

import '/Utils/console_log.dart';

import '/Widget/event_small_card.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String? idUser = GoRouterState.of(context).pathParameters['idUser'];

    return idUser == null
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'An error occurred while loading user profile! Please try again',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).go('/home');
                  },
                  child: const Text('Go back'),
                ),
              ],
            ),
          )
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 34, 34, 34),
            extendBody: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text(
                'User profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  GoRouter.of(context).pop();
                },
              ),
            ),
            body: SafeArea(
              top: true,
              bottom: false,
              child: StoreConnector<AppState, UserViewModel>(
                  converter: (store) => UserViewModel.create(store, idUser),
                  onInit: (store) {
                    store.dispatch(FetchUserAction(idUser));
                  },
                  distinct: true,
                  builder: (context, viewModel) {
                    logError(
                        "StoreConnector<AppState, UserViewModel> ${viewModel.organizedEventsIds}");

                    switch (viewModel.loadingStatus) {
                      case LoadingStatus.success:
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, bottom: 30),
                                  child: Row(
                                    children: [
                                      viewModel.user.profileImageUrl.isEmpty
                                          ? const CircleAvatar(
                                              radius: 50,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.person,
                                                size: 50,
                                                color: const Color.fromARGB(255, 34, 34, 34),
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 50,
                                              backgroundImage:
                                                  NetworkImage(viewModel.user.profileImageUrl),
                                            ),
                                      const SizedBox(width: 17),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            viewModel.user.username,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '${viewModel.user.name} ${viewModel.user.surname}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: viewModel.organizedEventsIds.isEmpty
                                      ? const Text(
                                          'This user has not organized any events yet.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Events organized:',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                              ),
                                            ),
                                            ...viewModel.organizedEventsIds
                                                .map((id) => eventSel(store, id)!)
                                                .sortedBy((event) => event.openingDateTime)
                                                .reversed
                                                .map(
                                                  (event) => EventSmallCard(
                                                    event: event,
                                                  ),
                                                )
                                          ],
                                        ),
                                ),
                              ],
                            ),
                          ),
                        );
                      case LoadingStatus.error:
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'An error occurred while fetching\nthis user profile',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  store.dispatch(FetchUserAction(idUser));
                                },
                                child: const Text('Try again'),
                              ),
                            ],
                          ),
                        );
                      case LoadingStatus.loading:
                      default:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                    }
                  }),
            ),
          );
  }
}
