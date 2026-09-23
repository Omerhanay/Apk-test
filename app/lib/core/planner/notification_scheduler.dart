import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// A scheduled on-device notification. [key] is the reminder id.
class ScheduledNotification {
  const ScheduledNotification({required this.key, required this.title, required this.at});
  final String key;
  final String title;
  final DateTime at;
}

abstract interface class NotificationScheduler {
  Future<void> schedule(ScheduledNotification n);
  Future<void> cancel(String key);

  /// Asks the OS for permission to post notifications (Android 13+).
  Future<bool> requestPermission();
}

/// Stable 31-bit notification id for a reminder id (FNV-1a).
int notificationIdFor(String key) {
  var hash = 0x811c9dc5;
  for (final unit in key.codeUnits) {
    hash ^= unit;
    hash = (hash * 0x01000193) & 0xffffffff;
  }
  return hash & 0x7fffffff;
}

/// Android notifications via flutter_local_notifications.
///
/// Inexact alarms: reminders may arrive a few minutes late on idle phones,
/// which avoids the exact-alarm permission. Visibility is private: on a secure
/// lock screen Android shows only the app name with "contents hidden".
class LocalNotificationScheduler implements NotificationScheduler {
  LocalNotificationScheduler._(this._plugin, this._channelName);

  final FlutterLocalNotificationsPlugin _plugin;
  final String _channelName;

  static Future<LocalNotificationScheduler> create({required String channelName}) async {
    tzdata.initializeTimeZones();
    try {
      tz.setLocalLocation(tz.getLocation((await FlutterTimezone.getLocalTimezone()).identifier));
    } on Object {
      // Unknown zone id: fall back to UTC offsets, still correct for absolute instants.
    }
    final plugin = FlutterLocalNotificationsPlugin();
    await plugin.initialize(
      settings: const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher')),
    );
    return LocalNotificationScheduler._(plugin, channelName);
  }

  @override
  Future<void> schedule(ScheduledNotification n) {
    final details = AndroidNotificationDetails(
      'reminders',
      _channelName,
      importance: Importance.high,
      priority: Priority.high,
      visibility: NotificationVisibility.private,
    );
    return _plugin.zonedSchedule(
      id: notificationIdFor(n.key),
      scheduledDate: tz.TZDateTime.from(n.at, tz.local),
      notificationDetails: NotificationDetails(android: details),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      title: n.title,
      payload: n.key,
    );
  }

  @override
  Future<void> cancel(String key) => _plugin.cancel(id: notificationIdFor(key));

  @override
  Future<bool> requestPermission() async =>
      await _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission() ??
      false;
}
