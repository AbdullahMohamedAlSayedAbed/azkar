import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/dua.dart';

abstract class DuasRepository {
  Future<Either<Failure, List<Dua>>> getDuasByCategory(String category);
}
