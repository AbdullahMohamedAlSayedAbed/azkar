import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/prayer_time.dart';
import '../../domain/repositories/prayer_times_repository.dart';
import '../datasources/prayer_times_data_source.dart';

class PrayerTimesRepositoryImpl implements PrayerTimesRepository {
  final PrayerTimesDataSource dataSource;

  PrayerTimesRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, PrayerTimesEntity>> getPrayerTimes({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final result = await dataSource.getPrayerTimes(latitude, longitude);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
