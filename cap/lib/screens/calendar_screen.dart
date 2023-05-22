import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:cap/services/event_service.dart';
import 'package:cap/models/event.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final EventDatabase _eventDatabase = EventDatabase.instance;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;

  List<String> events = []; // List of events for the selected date
  String selectedEvent = ''; // Currently selected event for detailed view

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _firstDay = DateTime(2023, 1, 1);
    _lastDay = DateTime(2023, 12, 31);
    _focusedDay = _selectedDay;

    _initializeDatabase(); // Initialize the database
  }

  Future<void> _initializeDatabase() async {
    await EventDatabase.instance.database;

    // Additional logic for your app, such as fetching events from the database
    // and updating the events list accordingly
  }

  void selectEvent(String event) {
    setState(() {
      selectedEvent = event;
    });
  }

  Future<void> _showAddEventDialog() async {
    final eventTitleController = TextEditingController();
    final locationController = TextEditingController();
    final descriptionController = TextEditingController();
    final attendeesController = TextEditingController();
    final TextEditingController typeController = TextEditingController();

    DateTime? startDate;
    DateTime? endDate;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Event'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: eventTitleController,
                  decoration: const InputDecoration(
                    labelText: 'Event Title',
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text('Date and Time'),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023, 1, 1),
                            lastDate: DateTime(2023, 12, 31),
                          );
                          if (selectedDate != null) {
                            setState(() {
                              startDate = selectedDate;
                            });
                          }
                        },
                        child: Text(
                          startDate != null
                              ? DateFormat('yyyy-MM-dd').format(startDate!)
                              : 'Select Start Date',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023, 1, 1),
                            lastDate: DateTime(2023, 12, 31),
                          );
                          if (selectedDate != null) {
                            setState(() {
                              endDate = selectedDate;
                            });
                          }
                        },
                        child: Text(
                          endDate != null
                              ? DateFormat('yyyy-MM-dd').format(endDate!)
                              : 'Select End Date',
                        ),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                  ),
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                TextFormField(
                  controller: attendeesController,
                  decoration: const InputDecoration(
                    labelText: 'Attendees',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Save event logic
                final event = Event(
                  title: eventTitleController.text,
                  startDate: startDate!,
                  endDate: endDate!,
                  location: locationController.text,
                  description: descriptionController.text,
                  attendees: attendeesController.text,
                  type: typeController.text,
                );

                // Insert the event into the database
                // int eventId = await _eventDatabase.insertEvent(event);
                await EventDatabase.instance.insertEvent(event);
                // Print the inserted event's ID
                //print('Inserted event ID: $eventId'); // Close the dialog
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events Calendar'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TableCalendar(
                focusedDay: _focusedDay,
                firstDay: _firstDay,
                lastDay: _lastDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    events = []; // Reset events list for the selected date
                  });
                },
                calendarStyle: CalendarStyle(
                    selectedDecoration: const BoxDecoration(
                      color: Colors.purple, // Change the color here
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.purple.shade100, // Change the color here
                      shape: BoxShape.circle,
                    )

                    // Add any additional properties and callbacks for the calendar
                    ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, focusedDay) {
                    if (date.weekday == DateTime.saturday ||
                        date.weekday == DateTime.sunday) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          date.day.toString(),
                          style: const TextStyle(
                            color: Colors.red, // Change weekend text color
                          ),
                        ),
                      );
                    } else {
                      return null; // Use the default builder for non-weekend days
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 16.0, height: 15.0),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 45.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: _showAddEventDialog,
                    // Add event logic

                    child: const Text('Add Event'),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      // Edit event logic
                    },
                    child: const Text('Edit Event'),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      // Remove event logic
                    },
                    child: const Text('Remove Event'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.purple.shade100,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Events on ${DateFormat('yyyy MMM, dd').format(_selectedDay)}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 2.0,
                      )),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return ListTile(
                          title: Text(event),
                          onTap: () {
                            selectEvent(event);
                          },
                        );
                      },
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 2.0,
                      )),
                ],
              ),
            ),
          ),
          if (selectedEvent.isNotEmpty)
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const Text(
                    'Selected Event',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(selectedEvent),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedEvent = '';
                      });
                    },
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
