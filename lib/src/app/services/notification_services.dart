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
        hour: 02,
        millisecond: 0,
        minute: 09,
      ),
      content: NotificationContent(
        id: 1,
        channelKey: "channelKey",
        title: "Hello",
        body: "Manage Your Expense",
        criticalAlert: true,
        wakeUpScreen: true,
        fullScreenIntent: true,
      ),
    );
  }
}
