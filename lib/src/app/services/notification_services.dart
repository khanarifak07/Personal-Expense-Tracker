import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: "channelKey",
          channelName: "channelName",
          channelDescription: "channelDescription",
          playSound: true,
          criticalAlerts: true,
          importance: NotificationImportance.Max,
        )
      ],
      debug: true,
    );
//Check for notification permission
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    //create schedule notification
    AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        hour: 19,
        millisecond: 0,
        minute: 50,
      ),
      content: NotificationContent(
          id: 1,
          channelKey: "channelKey",
          title: "Hello",
          body: "This is the body of notification"),
    );
  }
}
