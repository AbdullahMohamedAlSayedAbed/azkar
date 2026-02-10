import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/surah.dart';
import '../../domain/repositories/quran_repository.dart';
import '../datasources/quran_local_data_source.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranLocalDataSource localDataSource;

  QuranRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Surah>>> getSurahs() async {
    try {
      final localSurahs = await localDataSource.getSurahs();
      return Right(localSurahs);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
