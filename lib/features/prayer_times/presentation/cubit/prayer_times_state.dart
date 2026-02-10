part of 'prayer_times_cubit.dart';

enum PrayerTimesStatus { initial, loading, loaded, error }

class PrayerTimesState extends Equatable {
  final PrayerTimesStatus status;
  final Map<String, DateTime> prayerTimes;
  final String currentPrayer;
  final String nextPrayer;
  final Duration timeUntilNextPrayer;
  final String locationName;
  final String? errorMessage;

  const PrayerTimesState({
    this.status = PrayerTimesStatus.initial,
    this.prayerTimes = const {},
    this.currentPrayer = '',
    this.nextPrayer = '',
    this.timeUntilNextPrayer = Duration.zero,
    this.locationName = '',
    this.errorMessage,
  });

  DateTime? get fajr => prayerTimes['fajr'];
  DateTime? get sunrise => prayerTimes['sunrise'];
  DateTime? get dhuhr => prayerTimes['dhuhr'];
  DateTime? get asr => prayerTimes['asr'];
  DateTime? get maghrib => prayerTimes['maghrib'];
  DateTime? get isha => prayerTimes['isha'];

  PrayerTimesState copyWith({
    PrayerTimesStatus? status,
    Map<String, DateTime>? prayerTimes,
    String? currentPrayer,
    String? nextPrayer,
    Duration? timeUntilNextPrayer,
    String? locationName,
    String? errorMessage,
  }) {
    return PrayerTimesState(
      status: status ?? this.status,
      prayerTimes: prayerTimes ?? this.prayerTimes,
      currentPrayer: currentPrayer ?? this.currentPrayer,
      nextPrayer: nextPrayer ?? this.nextPrayer,
      timeUntilNextPrayer: timeUntilNextPrayer ?? this.timeUntilNextPrayer,
      locationName: locationName ?? this.locationName,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        prayerTimes,
        currentPrayer,
        nextPrayer,
        timeUntilNextPrayer,
        locationName,
        errorMessage,
      ];
}
