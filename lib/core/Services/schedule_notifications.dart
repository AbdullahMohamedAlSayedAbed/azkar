import 'package:azkar/core/Services/notifications_helper.dart';

class ScheduleAzkarNotifications {
  Future<void> scheduleMorningAndEveningNotifications() async {
    // وقت أذكار الصباح
    await NotificationHelper.scheduleNotification(
      id: 1,
      title: 'أذكار الصباح',
      body: 'حان الآن وقت أذكار الصباح.',
      scheduledTime: _getNextTime(hour: 6, minute: 0),
    );

    // وقت أذكار المساء
    await NotificationHelper.scheduleNotification(
      id: 2,
      title: 'أذكار المساء',
      body: 'حان الآن وقت أذكار المساء.',
      scheduledTime: _getNextTime(hour: 18, minute: 0),
    );
  }

  DateTime _getNextTime({required int hour, required int minute}) {
    final now = DateTime.now();
    final scheduled = DateTime(now.year, now.month, now.day, hour, minute);
    return scheduled.isBefore(now) ? scheduled.add(const Duration(days: 1)) : scheduled;
}
}