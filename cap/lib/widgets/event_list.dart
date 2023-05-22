import 'package:flutter/material.dart';
import 'package:cap/models/event.dart';

class EventList extends StatelessWidget {
  final List<Event> events;

  const EventList({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return ListTile(
          title: Text(event.title),
          subtitle: Text(event.type),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              //TODO: Implement delete event functionality
            },
          ),
        );
      },
    );
  }
}
