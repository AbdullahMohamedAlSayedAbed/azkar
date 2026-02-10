import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../datasources/duas_local_datasource.dart';
import '../../domain/entities/dua.dart';
import '../../domain/repositories/duas_repository.dart';

class DuasRepositoryImpl implements DuasRepository {
  @override
  Future<Either<Failure, List<Dua>>> getDuasByCategory(String category) async {
    try {
      final List<Dua> duas = DuasLocalDataSource.getByCategory(category);
      return Right(duas);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
