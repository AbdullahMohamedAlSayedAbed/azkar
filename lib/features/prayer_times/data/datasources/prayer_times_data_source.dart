import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/prayer_time.dart';

abstract class PrayerTimesDataSource {
  Future<PrayerTimesEntity> getPrayerTimes(double latitude, double longitude);
}

class PrayerTimesDataSourceImpl implements PrayerTimesDataSource {
  @override
  Future<PrayerTimesEntity> getPrayerTimes(
      double latitude, double longitude) async {
    final definitions = CalculationMethod.egyptian.getParameters();
    definitions.madhab = Madhab.shafi;

    final coordinates = Coordinates(latitude, longitude);
    final date = DateComponents.from(DateTime.now());
    final prayerTimes = PrayerTimes(coordinates, date, definitions);

    return PrayerTimesEntity(
      fajr: prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      dhuhr: prayerTimes.dhuhr,
      asr: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isha: prayerTimes.isha,
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
  }
}
