/// Prayer Times Cubit
/// Manages prayer times state based on location
library;

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:azkar/core/services/location_service.dart';
import 'package:azkar/core/services/notification_service.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/usecases/get_prayer_times.dart';

part 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  final LocationService locationService;
  final GetPrayerTimes getPrayerTimes;
  final NotificationService notificationService;
  Timer? _timer;

  PrayerTimesCubit({
    required this.locationService,
    required this.getPrayerTimes,
    required this.notificationService,
  }) : super(const PrayerTimesState());

  Future<void> loadPrayerTimes() async {
    emit(state.copyWith(status: PrayerTimesStatus.loading));

    try {
      Position? position = await locationService.getCurrentPosition();

      double lat = position?.latitude ?? 30.0444;
      double lon = position?.longitude ?? 31.2357;
      String locationName =
          position != null ? 'موقعك الحالي' : 'القاهرة (افتراضي)';

      final result = await getPrayerTimes(PrayerTimesParams(
        latitude: lat,
        longitude: lon,
      ));

      result.fold(
        (failure) => emit(state.copyWith(
          status: PrayerTimesStatus.error,
          errorMessage: failure.message,
        )),
        (prayerTimesEntity) {
          final times = <String, DateTime>{
            'fajr': prayerTimesEntity.fajr,
            'sunrise': prayerTimesEntity.sunrise,
            'dhuhr': prayerTimesEntity.dhuhr,
            'asr': prayerTimesEntity.asr,
            'maghrib': prayerTimesEntity.maghrib,
            'isha': prayerTimesEntity.isha,
          };

          emit(state.copyWith(locationName: locationName));
          _updateNextPrayer(times);
          _scheduleNotifications(times);
          _startTimer();
        },
      );
    } catch (e) {
      // Load with Cairo fallback on error
      final result = await getPrayerTimes(const PrayerTimesParams(
        latitude: 30.0444,
        longitude: 31.2357,
      ));
      result.fold(
        (failure) => emit(state.copyWith(
          status: PrayerTimesStatus.error,
          errorMessage: 'تعذر تحميل المواقيت، تأكد من الاتصال بالإنترنت',
        )),
        (prayerTimesEntity) {
          final times = <String, DateTime>{
            'fajr': prayerTimesEntity.fajr,
            'sunrise': prayerTimesEntity.sunrise,
            'dhuhr': prayerTimesEntity.dhuhr,
            'asr': prayerTimesEntity.asr,
            'maghrib': prayerTimesEntity.maghrib,
            'isha': prayerTimesEntity.isha,
          };
          emit(state.copyWith(locationName: 'القاهرة (افتراضي)'));
          _updateNextPrayer(times);
          _startTimer();
        },
      );
    }
  }

  void _updateNextPrayer(Map<String, DateTime> times) {
    // Determine current and next prayer
    final now = DateTime.now();
    String currentPrayer = '';
    String nextPrayer = '';
    DateTime? nextPrayerTime;

    final prayerOrder = ['fajr', 'sunrise', 'dhuhr', 'asr', 'maghrib', 'isha'];

    for (int i = 0; i < prayerOrder.length; i++) {
      final prayer = prayerOrder[i];
      final time = times[prayer]!;

      if (now.isBefore(time)) {
        nextPrayer = prayer;
        nextPrayerTime = time;
        if (i > 0) {
          currentPrayer = prayerOrder[i - 1];
        } else {
          // If next is Fajr, current is Isha from yesterday (or technically just previous)
          currentPrayer = 'isha';
        }
        break;
      }
    }

    // If after isha, next is fajr tomorrow
    if (nextPrayer.isEmpty) {
      currentPrayer = 'isha';
      nextPrayer = 'fajr';
      // We need tomorrow's Fajr.
      // Ideally we should fetch tomorrow's prayer times.
      // For now, approximate by adding 24 hours to today's Fajr
      // OR better, create a new request for tomorrow.
      // But given the scope, let's just add 1 day to today's Fajr for simplicity
      // creating a slight inaccuracy if Fajr time changes significantly.
      // A better clean arch approach would be to ask UseCase for "Next Prayer".
      nextPrayerTime = times['fajr']!.add(const Duration(days: 1));
    }

    final timeUntilNext = nextPrayerTime!.difference(now);

    emit(state.copyWith(
      status: PrayerTimesStatus.loaded,
      prayerTimes: times,
      currentPrayer: currentPrayer,
      nextPrayer: nextPrayer,
      timeUntilNextPrayer: timeUntilNext,
      locationName: 'موقعك الحالي',
    ));
  }

  Future<void> _scheduleNotifications(Map<String, DateTime> times) async {
    await notificationService.cancelAllNotifications();

    int id = 10;
    times.forEach((prayerName, time) {
      if (prayerName == 'sunrise') return; // No adhan for sunrise

      if (time.isAfter(DateTime.now())) {
        notificationService.schedulePrayerNotification(
            id: id++,
            prayerName: getPrayerNameArabic(prayerName),
            prayerTime: time);
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.timeUntilNextPrayer.inSeconds > 0) {
        emit(state.copyWith(
          timeUntilNextPrayer:
              state.timeUntilNextPrayer - const Duration(seconds: 1),
        ));
      } else {
        // Prayer time reached, reload
        loadPrayerTimes();
      }
    });
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String getPrayerNameArabic(String prayer) {
    switch (prayer) {
      case 'fajr':
        return 'الفجر';
      case 'sunrise':
        return 'الشروق';
      case 'dhuhr':
        return 'الظهر';
      case 'asr':
        return 'العصر';
      case 'maghrib':
        return 'المغرب';
      case 'isha':
        return 'العشاء';
      default:
        return prayer;
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
