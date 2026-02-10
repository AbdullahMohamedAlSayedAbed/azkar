import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/prayer_time.dart';
import '../repositories/prayer_times_repository.dart';

class GetPrayerTimes implements UseCase<PrayerTimesEntity, PrayerTimesParams> {
  final PrayerTimesRepository repository;

  GetPrayerTimes(this.repository);

  @override
  Future<Either<Failure, PrayerTimesEntity>> call(
      PrayerTimesParams params) async {
    return await repository.getPrayerTimes(
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
}

class PrayerTimesParams extends Equatable {
  final double latitude;
  final double longitude;

  const PrayerTimesParams({required this.latitude, required this.longitude});

  @override
  List<Object> get props => [latitude, longitude];
}
