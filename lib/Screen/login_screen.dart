import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a login page Scaffold, it needs an email field, a password field, a submit button, a password forgotten small text button and a login with google button
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            TextButton(
              child: const Text('Login'),
              onPressed: () {
                
              },
            ),
            const SizedBox(
              height: 12,
            ),
            const Text('Or'),
            const SizedBox(
              height: 12,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                // TODO: Emit login with google event
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logos/google_logo.png',
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Login with Google",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
