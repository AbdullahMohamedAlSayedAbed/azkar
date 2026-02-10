import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/zikr.dart';
import '../repositories/azkar_repository.dart';

class GetAzkarByCategory implements UseCase<List<Zikr>, String> {
  final AzkarRepository repository;

  GetAzkarByCategory(this.repository);

  @override
  Future<Either<Failure, List<Zikr>>> call(String category) async {
    return await repository.getAzkarByCategory(category);
  }
}
