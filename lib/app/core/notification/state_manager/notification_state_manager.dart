import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../model/notification_entity.dart';


class NotificationStateManager with ChangeNotifier {
  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;

  NotificationProvider() {
    fetchNotifications();
  }

  // Fetch all notifications from the database
  Future<void> fetchNotifications() async {
    _notifications.clear();
    _notifications = await DatabaseHelper.instance.fetchAllNotifications();

    _notifications.forEach((element) {
      print('${element.title} - ${element.bookingId}');
    });


    print('At the moment those number of notifications are present: ${notifications.length}');
    notifyListeners();
  }

  // Add a new notification
  Future<void> addNotification(NotificationModel notification) async {
    print('Create notification and fetch: ${notification.toMap()}');
    await DatabaseHelper.instance.insertNotification(notification);
    await fetchNotifications();
  }

  // Delete a notification by ID
  Future<void> deleteNotification(int id) async {
    await DatabaseHelper.instance.deleteNotification(id);
    await fetchNotifications(); // Refresh the notifications list
  }

  Future<void> deleteAll() async {
    await DatabaseHelper.instance.deleteAll();
    await fetchNotifications();
  }

  Future<void> setAllNotificationToRead(bool updateAfterQuery) async {
    await DatabaseHelper.instance.setAllNotificationToReadStatus();
    if(updateAfterQuery){
      await fetchNotifications();
    }
  }
}
