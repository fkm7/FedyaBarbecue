import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel _channel = AndroidNotificationChannel(
  'high_importance_channel', //id
  'High Importance Notifications', //name
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
);

AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
  _channel.id, //id
  _channel.name, //name
  channelDescription: _channel.description,
  icon: 'ic_launcher',
  importance: _channel.importance,
);

NotificationDetails platformChannelSpecifics = NotificationDetails(
  android: androidPlatformChannelSpecifics,
  iOS: const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  ),
);

class PushNotificationService {
  static final PushNotificationService _pushNotificationService = PushNotificationService._internal();

  factory PushNotificationService() => _pushNotificationService;

  PushNotificationService._internal() {
    initialize();
  }

  void requestPermission() async {
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future initialize() async {
    requestPermission();
    tz.initializeTimeZones();
    const initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(_channel);
  }

  // Future<void> setRepeatableNotification(Task task) async {
  //   RepeatInterval repeat = RepeatInterval.daily;
  //   if (TaskType.everyWeek.name == task.taskType) {
  //     repeat = RepeatInterval.weekly;
  //   }
  //
  //   await flutterLocalNotificationsPlugin.periodicallyShow(
  //     task.hashCode,
  //     task.taskName,
  //     task.taskDescription,
  //     repeat,
  //     platformChannelSpecifics,
  //     androidAllowWhileIdle: true,
  //   );
  // }

  // Future<void> scheduledNotification(Task task) async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     task.hashCode,
  //     task.taskName,
  //     task.taskDescription,
  //     convertTime(DateTime.parse(task.appointedTime)),
  //     platformChannelSpecifics,
  //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //     matchDateTimeComponents: DateTimeComponents.dateAndTime,
  //     androidAllowWhileIdle: true,
  //   );
  // }

  Future<void> showNotification(int id, String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  // tz.TZDateTime convertTime(DateTime dateTime) {
  //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  //   tz.TZDateTime scheduledTime = tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, dateTime.millisecondsSinceEpoch);
  //   // print(tz.local.transitionZon);
  //   if (scheduledTime.isBefore(now)) {
  //     scheduledTime = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
  //   }
  //   return scheduledTime;
  // }

  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {}

  void onSelectNotification(String? payload) {}
}
