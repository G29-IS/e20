import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';

import '/Models/enums.dart';

import '/Redux/store.dart';
import '/Redux/App/app_state.dart';
import '/Redux/selectors.dart';
import '/Redux/Auth/auth_actions.dart';
import '/Redux/ViewModels/current_profileVM.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      extendBody: true,
      body: tokenSel(store) == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Please, log in to see your profile.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    child: const Text('Log in'),
                  ),
                ],
              ),
            )
          : SafeArea(
              top: true,
              bottom: false,
              child: StoreConnector<AppState, CurrentProfileViewModel>(
                  converter: (store) => CurrentProfileViewModel.create(store),
                  onInit: (store) {
                    store.dispatch(FetchCurrentUserAction());
                  },
                  distinct: true,
                  builder: (context, viewModel) {
                    switch (viewModel.loadingStatus) {
                      case LoadingStatus.success:
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              Row(
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
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // store.dispatch(LogoutAction());
                                  },
                                  child: const Text('Log out'),
                                ),
                              ),
                              viewModel.organizedEventsIds.isEmpty
                                  ? const Text(
                                      'You have not organized any events yet.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    )
                                  : const Text(
                                      'Events you have organized:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                              if (viewModel.organizedEventsIds.isNotEmpty)
                                ...viewModel.organizedEventsIds.map((id) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        eventSel(store, id).toString(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    )),
                            ],
                          ),
                        );
                      case LoadingStatus.error:
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'An error occurred while fetching your profile.',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  store.dispatch(FetchCurrentUserAction());
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
