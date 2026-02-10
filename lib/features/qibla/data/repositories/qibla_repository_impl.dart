import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/location_service.dart';
import '../../domain/entities/qibla_data.dart';
import '../../domain/repositories/qibla_repository.dart';

class QiblaRepositoryImpl implements QiblaRepository {
  final LocationService locationService;

  QiblaRepositoryImpl({required this.locationService});

  @override
  Future<Either<Failure, QiblaData>> getQiblaData() async {
    try {
      final direction = await locationService.getQiblaDirection();
      final distance = await locationService.getDistanceToKaaba();

      if (direction != null && distance != null) {
        return Right(QiblaData(direction: direction, distance: distance));
      } else {
        return const Left(NetworkFailure('Could not determine location'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
