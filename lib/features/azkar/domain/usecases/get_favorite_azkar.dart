import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/zikr.dart';
import '../repositories/azkar_repository.dart';

class GetFavoriteAzkar implements UseCase<List<Zikr>, NoParams> {
  final AzkarRepository repository;

  GetFavoriteAzkar(this.repository);

  @override
  Future<Either<Failure, List<Zikr>>> call(NoParams params) async {
    return await repository.getFavoriteAzkar();
  }
}
