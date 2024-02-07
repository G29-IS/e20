import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/Models/event.dart';

class EventSmallCard extends StatelessWidget {
  const EventSmallCard({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(event.coverImageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Container(
                  child: Text(
                    '${DateFormat('EEE, d MMM y - HH:MM').format(event.openingDateTime)}\n${event.place.name ?? event.place.address}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
