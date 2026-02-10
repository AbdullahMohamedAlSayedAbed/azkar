import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/tasbeeh_repository.dart';

class GetTasbeehTotal implements UseCase<int, NoParams> {
  final TasbeehRepository repository;

  GetTasbeehTotal(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await repository.getTotalCount();
  }
}
