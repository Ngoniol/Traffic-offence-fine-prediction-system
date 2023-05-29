import 'package:awesome_notifications/awesome_notifications.dart';

 sendNotification() {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 10,
        channelKey: 'channelKey',
      title: 'Traffic System',
      body: 'You have successfully registered an offense',
    ),
  );
}