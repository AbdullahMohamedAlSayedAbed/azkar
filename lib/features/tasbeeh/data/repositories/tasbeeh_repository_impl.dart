import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/hive_service.dart';
import '../../domain/repositories/tasbeeh_repository.dart';

class TasbeehRepositoryImpl implements TasbeehRepository {
  final HiveService hiveService;

  TasbeehRepositoryImpl({required this.hiveService});

  @override
  Future<Either<Failure, int>> getTotalCount() async {
    try {
      final total = hiveService.getTotalTasbeeh();
      return Right(total);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveTotalCount(int count) async {
    try {
      await hiveService.saveTotalTasbeeh(count);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
