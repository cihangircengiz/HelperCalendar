import 'package:flutter/material.dart';
import 'package:scheduled_notifications/scheduled_notifications.dart';
class NotificationPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    _scheduleNotification();
    return new Icon(Icons.directions_transit);
  }
  _scheduleNotification() async {
    int notificationId = await ScheduledNotifications.scheduleNotification(
        new DateTime.now().add(new Duration(days: 1)).millisecondsSinceEpoch,
        "Ticker text",
        "HalperCalendar",
        "Durring class is MATH 486 C604");
  }
}