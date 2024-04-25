import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/Models/enums.dart';
import '/Models/event.dart';
import '/Models/event_place.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 34, 34),
      extendBody: true,
      body: SafeArea(
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
                            visibility: EventVisibility.public,
                            availability: EventAvailability.available,
                            type: EventType.concert,
                            name: nameController.text,
                            description: descriptionController.text,
                            coverImageUrl: coverImageUrlController.text,
                            openingDateTime: DateTime.now(),
                            doorOpeningDateTime: DateTime.now(),
                            place: EventPlace(
                                name: placeNameController.text,
                                address: placeAddressController.text,
                                url: 'https://maps.google.com'),
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
  }
}
