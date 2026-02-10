import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/tasbeeh_repository.dart';

class SaveTasbeehTotal implements UseCase<void, int> {
  final TasbeehRepository repository;

  SaveTasbeehTotal(this.repository);

  @override
  Future<Either<Failure, void>> call(int count) async {
    return await repository.saveTotalCount(count);
  }
}
