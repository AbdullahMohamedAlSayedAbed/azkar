import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/qibla_data.dart';

abstract class QiblaRepository {
  Future<Either<Failure, QiblaData>> getQiblaData();
}
