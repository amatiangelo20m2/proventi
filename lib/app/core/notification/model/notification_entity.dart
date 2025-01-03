class NotificationModel {
  final int? id;
  final String title;
  final String body;
  final String dateReceived;
  final String read;
  final String bookingId;
  final String navigationPage;

  NotificationModel({this.id,
    required this.title,
    required this.body,
    required this.dateReceived,
    required this.read,
    required this.bookingId,
    required this.navigationPage});

  // Convert a Notification to a Map (for inserting to the DB)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'dateReceived': dateReceived,
      'read' : read,
      'bookingId' : bookingId,
      'navigationPage' : navigationPage
    };
  }

  // Convert a Map to a Notification object
  static NotificationModel fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      dateReceived: map['dateReceived'],
      read: map['read'],
      bookingId: map['bookingId'],
      navigationPage: map['navigationPage'],
    );
  }
}
