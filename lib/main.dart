import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:e20/firebase_options.dart';

import '/Redux/store.dart';

import '/Screen/home_screen.dart';
import '/Screen/login_screen.dart';

import '/Utils/console_log.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  logWarning('Initializing Firebase');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).onError((error, stackTrace) {
    logError(error.toString());
    return Future.error(error as Object);
  });
  logSuccess('Firebase initialized');

  runApp(const MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp.router(
        title: 'E20',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 30, 215, 96)),
          useMaterial3: true,
          fontFamily: 'Outfit',
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
