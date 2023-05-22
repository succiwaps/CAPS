class Event {
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final String description;
  final String attendees;
  final String type;

  Event({
    this.id = 0,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.description,
    required this.attendees,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
      'location': location,
      'description': description,
      'attendees': attendees,
      'type': type,
    };
  }
}
