import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';

import '/Models/enums.dart';

import '/Redux/App/app_state.dart';
import '/Redux/ViewModels/current_profileVM.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController emailController = TextEditingController();

  bool validatefields() {
    if (emailController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // Create a login page Scaffold, it needs an email field, a password field, a submit button, a password forgotten small text button and a login with google button
    return StoreConnector<AppState, CurrentProfileViewModel>(
        converter: (store) => CurrentProfileViewModel.create(store),
        builder: (context, viewModel) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 34, 34, 34),
            appBar: AppBar(
              title: const Text('Password dimenticata',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: const Color.fromARGB(255, 34, 34, 34),
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  context.go('/login');
                },
              ),
            ),
            body: SafeArea(
              top: true,
              bottom: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        label: const Text('Email'),
                        hintStyle: const TextStyle(color: Colors.white),
                        enabled:
                            viewModel.loadingStatus != LoadingStatus.loading,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        if (validatefields()) {
                          viewModel.resetPassword(emailController.text);

                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Istruzioni inviate'),
                                content: const Text(
                                  'Sono state inviate istruzioni per il reset della password alla email inserita!',
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    child: const Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: viewModel.loadingStatus == LoadingStatus.loading
                          ? const CircularProgressIndicator()
                          : const Text('Manda email'),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
