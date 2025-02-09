import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';

import '/Models/enums.dart';

import '/Redux/App/app_state.dart';
import '/Redux/ViewModels/current_profileVM.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(text: "default@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "g29-password");

  bool isPasswordVisible = false;

  bool validatefields() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void changePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
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
              title: const Text('Login', style: TextStyle(color: Colors.white)),
              backgroundColor: const Color.fromARGB(255, 34, 34, 34),
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  context.go('/home');
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
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        label: const Text('Email'),
                        hintStyle: const TextStyle(color: Colors.white),
                        enabled: viewModel.loadingStatus != LoadingStatus.loading,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      obscureText: isPasswordVisible ? false : true,
                      obscuringCharacter: "*",
                      keyboardType: TextInputType.visiblePassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        hintStyle: const TextStyle(color: Colors.white),
                        enabled: viewModel.loadingStatus != LoadingStatus.loading,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: changePasswordVisibility,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    if (viewModel.loadingStatus == LoadingStatus.error)
                      const Text(
                        'Invalid email or password',
                        style: TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        if (validatefields()) {
                          viewModel.login(emailController.text, passwordController.text, context);
                        }
                      },
                      child: viewModel.loadingStatus == LoadingStatus.loading
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 25),
                    //   child: Text('Or', style: TextStyle(color: Colors.white)),
                    // ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8),
                    //     color: Colors.white24,
                    //     border: Border.all(),
                    //   ),
                    //   padding: const EdgeInsets.all(12),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Image.asset(
                    //         'assets/logos/google_logo.png',
                    //         height: 30,
                    //         width: 30,
                    //       ),
                    //       const SizedBox(
                    //         width: 12,
                    //       ),
                    //       Text(
                    //         "Login with Google",
                    //         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    //               color: Colors.white,
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextButton(
                        onPressed: () {
                          context.go('/password');
                        },
                        child: const Text(
                          'Forgot your password? Reset it by clicking here.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
