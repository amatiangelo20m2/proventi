class MessageModel {
  final int? id;
  final String messageId;

  MessageModel({this.id,
    required this.messageId,});

  // Convert a Notification to a Map (for inserting to the DB)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'messageId': messageId
    };
  }

  // Convert a Map to a Notification object
  static MessageModel fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      messageId: map['messageId'],
    );
  }
}
