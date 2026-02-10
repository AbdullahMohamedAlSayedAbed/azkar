import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/azkar_repository.dart';

class GetCategoryProgress implements UseCase<Map<String, int>, String> {
  final AzkarRepository repository;

  GetCategoryProgress(this.repository);

  @override
  Future<Either<Failure, Map<String, int>>> call(String category) async {
    return await repository.getCategoryProgress(category);
  }
}
