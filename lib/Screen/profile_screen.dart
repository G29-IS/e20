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
          : StoreConnector<AppState, CurrentProfileViewModel>(
              converter: (store) => CurrentProfileViewModel.create(store),
              onInit: (store) {
                store.dispatch(FetchCurrentUserAction());
              },
              distinct: true,
              builder: (context, viewModel) {
                switch (viewModel.loadingStatus) {
                  case LoadingStatus.success:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome, ${viewModel.user.name}!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // store.dispatch(LogoutAction());
                            },
                            child: const Text('Log out'),
                          ),
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
    );
  }
}
