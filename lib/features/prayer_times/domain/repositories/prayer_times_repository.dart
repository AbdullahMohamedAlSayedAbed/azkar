import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/prayer_time.dart';

abstract class PrayerTimesRepository {
  Future<Either<Failure, PrayerTimesEntity>> getPrayerTimes({
    required double latitude,
    required double longitude,
  });
}
