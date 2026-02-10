import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class TasbeehRepository {
  Future<Either<Failure, int>> getTotalCount();
  Future<Either<Failure, void>> saveTotalCount(int count);
}
