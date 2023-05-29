import 'package:awesome_notifications/awesome_notifications.dart';

 sendNotification(String court) {
   DateTime scheduledDate = DateTime.now().add(const Duration(seconds: 30));

   AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 10,
        channelKey: 'channelKey',
      title: 'Traffic System Reminder',
      body: 'You are required to go to $court tomorrow',
    ),schedule: NotificationCalendar.fromDate(date: scheduledDate),
  );
}