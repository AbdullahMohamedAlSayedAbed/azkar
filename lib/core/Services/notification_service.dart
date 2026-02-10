/// Enhanced Notification Service
/// Handles all app notifications including prayer times and azkar reminders
library;

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // Notification Channels
  static const String azkarChannelId = 'azkar_channel';
  static const String prayerChannelId = 'prayer_channel';
  static const String dailyReminderChannelId = 'daily_reminder_channel';

  // Notification IDs
  static const int morningAzkarId = 1;
  static const int eveningAzkarId = 2;
  static const int fajrPrayerId = 10;
  static const int dhuhrPrayerId = 11;
  static const int asrPrayerId = 12;
  static const int maghribPrayerId = 13;
  static const int ishaPrayerId = 14;

  Future<void> init() async {
    tz.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channels
    await _createNotificationChannels();
  }

  Future<void> _createNotificationChannels() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      // Azkar Channel
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          azkarChannelId,
          'أذكار',
          description: 'تنبيهات أذكار الصباح والمساء',
          importance: Importance.high,
          playSound: true,
        ),
      );

      // Prayer Channel
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          prayerChannelId,
          'مواقيت الصلاة',
          description: 'تنبيهات مواقيت الصلاة',
          importance: Importance.max,
          playSound: true,
        ),
      );

      // Daily Reminder Channel
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          dailyReminderChannelId,
          'تذكيرات يومية',
          description: 'تذكيرات يومية للعبادات',
          importance: Importance.defaultImportance,
          playSound: true,
        ),
      );
    }
  }

  void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    final payload = response.payload;
    debugPrint('Notification tapped: $payload');
  }

  /// Request notification permission
  Future<bool> requestPermission() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      return await androidPlugin.requestNotificationsPermission() ?? false;
    }
    return true;
  }

  /// Show immediate notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    String channelId = azkarChannelId,
  }) async {
    await _plugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelId == prayerChannelId ? 'مواقيت الصلاة' : 'أذكار',
          importance: Importance.high,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(body),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }

  /// Schedule notification at specific time
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
    String channelId = azkarChannelId,
    bool repeating = false,
  }) async {
    final tzDateTime = tz.TZDateTime.from(scheduledTime, tz.local);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tzDateTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelId == prayerChannelId ? 'مواقيت الصلاة' : 'أذكار',
          importance: Importance.high,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(body),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: repeating ? DateTimeComponents.time : null,
      payload: payload,
    );
  }

  /// Schedule morning azkar notification
  Future<void> scheduleMorningAzkar({int hour = 6, int minute = 0}) async {
    final now = DateTime.now();
    var scheduledTime = DateTime(now.year, now.month, now.day, hour, minute);

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    await scheduleNotification(
      id: morningAzkarId,
      title: '🌅 أذكار الصباح',
      body: 'حان وقت أذكار الصباح، ابدأ يومك بذكر الله',
      scheduledTime: scheduledTime,
      repeating: true,
    );
  }

  /// Schedule evening azkar notification
  Future<void> scheduleEveningAzkar({int hour = 17, int minute = 0}) async {
    final now = DateTime.now();
    var scheduledTime = DateTime(now.year, now.month, now.day, hour, minute);

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    await scheduleNotification(
      id: eveningAzkarId,
      title: '🌙 أذكار المساء',
      body: 'حان وقت أذكار المساء، اختم يومك بذكر الله',
      scheduledTime: scheduledTime,
      repeating: true,
    );
  }

  /// Schedule prayer notification
  Future<void> schedulePrayerNotification({
    required int id,
    required String prayerName,
    required DateTime prayerTime,
    int minutesBefore = 0,
  }) async {
    final notificationTime =
        prayerTime.subtract(Duration(minutes: minutesBefore));

    await scheduleNotification(
      id: id,
      title: '🕌 $prayerName',
      body: minutesBefore > 0
          ? 'بقي $minutesBefore دقيقة على أذان $prayerName'
          : 'حان وقت $prayerName',
      scheduledTime: notificationTime,
      channelId: prayerChannelId,
    );
  }

  /// Cancel specific notification
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  /// Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _plugin.pendingNotificationRequests();
  }
}
