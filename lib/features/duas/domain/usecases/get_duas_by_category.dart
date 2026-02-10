import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dua.dart';
import '../repositories/duas_repository.dart';

class GetDuasByCategory implements UseCase<List<Dua>, String> {
  final DuasRepository repository;

  GetDuasByCategory(this.repository);

  @override
  Future<Either<Failure, List<Dua>>> call(String category) async {
    return await repository.getDuasByCategory(category);
  }
}
