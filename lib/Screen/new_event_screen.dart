import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';

import '/Models/enums.dart';
import '/Models/event.dart';
import '/Models/event_place.dart';

import '/Redux/App/app_state.dart';
import '/Redux/Auth/auth_state.dart';
import '/Redux/Events/events_actions.dart';
import '/Redux/store.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController coverImageUrlController = TextEditingController();
  TextEditingController placeNameController = TextEditingController();
  TextEditingController placeAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    coverImageUrlController.text =
        'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=3000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthState>(
      converter: (store) => store.state.authState,
      builder: (context, authState) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 34, 34, 34),
          extendBody: true,
          body: authState.authToken == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Please log in to create\n a new event',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 30, bottom: 20),
                            child: Text(
                              'Create a new event',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: nameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Event name',
                              hintStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: descriptionController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Event description',
                              hintStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: coverImageUrlController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Event cover image URL',
                              hintStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                            ),
                            onTap: () => coverImageUrlController.text = '',
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),

                          const SizedBox(height: 15),
                          const Text(
                            'Cover image preview',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 5),

                          coverImageUrlController.text.isEmpty
                              ? const SizedBox(
                                  height: 200,
                                  child: Placeholder(
                                    color: Colors.green,
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(coverImageUrlController.text),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                          // const SizedBox(height: 15),
                          // TextField(
                          //   decoration: InputDecoration(
                          //     hintText: 'Event opening date and time',
                          //     hintStyle: const TextStyle(color: Colors.white),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //       borderSide: const BorderSide(color: Colors.white),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(height: 15),
                          // TextField(
                          //   decoration: InputDecoration(
                          //     hintText: 'Event closing date and time',
                          //     hintStyle: const TextStyle(color: Colors.white),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //       borderSide: const BorderSide(color: Colors.white),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: placeNameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Event place name',
                              hintStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: placeAddressController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Event place address',
                              hintStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: ElevatedButton(
                              child: const Text('Create event'),
                              onPressed: () {
                                store.dispatch(
                                  CreateNewEventAction(
                                    Event(
                                      idEvent: '',
                                      idOrganizer: '',
                                      visibility: EventVisibility.PUBLIC,
                                      availability: EventAvailability.AVAILABLE,
                                      type: EventType.CONCERT,
                                      name: nameController.text,
                                      description: descriptionController.text,
                                      coverImageUrl: coverImageUrlController.text,
                                      openingDateTime: DateTime.now(),
                                      doorOpeningDateTime: DateTime.now(),
                                      place: EventPlace(
                                        name: placeNameController.text,
                                        address: placeAddressController.text,
                                        url: 'https://maps.google.com',
                                      ),
                                    ),
                                    context,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
