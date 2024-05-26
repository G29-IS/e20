import 'package:e20/Redux/ViewModels/eventVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';


import '/Redux/App/app_state.dart';


class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String idEvent = GoRouterState.of(context).pathParameters['idEvent']!;
    return StoreConnector<AppState, EventViewModel>(
        converter: (store) => EventViewModel.create(store, idEvent),
        builder: (context, vm) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 34, 34, 34),
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
                toolbarHeight: 50,
                leadingWidth: 100,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.black),
                    ),
                    child: const Icon(Icons.close, color: Colors.white),
                  )
                ]),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image.network(
                          vm.event.coverImageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Text(
                          vm.event.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Text(
                      vm.event.description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Date: ${vm.event.openingDateTime}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Location: ${vm.event.place.name ?? vm.event.place.address}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
