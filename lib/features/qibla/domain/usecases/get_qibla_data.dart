import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/qibla_data.dart';
import '../repositories/qibla_repository.dart';

class GetQiblaData implements UseCase<QiblaData, NoParams> {
  final QiblaRepository repository;

  GetQiblaData(this.repository);

  @override
  Future<Either<Failure, QiblaData>> call(NoParams params) async {
    return await repository.getQiblaData();
  }
}
