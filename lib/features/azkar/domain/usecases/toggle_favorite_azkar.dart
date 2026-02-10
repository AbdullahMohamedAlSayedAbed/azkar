import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/azkar_repository.dart';

class ToggleFavoriteAzkar implements UseCase<bool, String> {
  final AzkarRepository repository;

  ToggleFavoriteAzkar(this.repository);

  @override
  Future<Either<Failure, bool>> call(String zikrId) async {
    // Check if it is currently favorite
    final isFavResult = await repository.isFavorite(zikrId);

    return isFavResult.fold(
      (failure) => Future.value(Left(failure)),
      (isFav) async {
        if (isFav) {
          final removeResult = await repository.removeFromFavorites(zikrId);
          return removeResult.fold(
            (failure) => Left(failure),
            (_) => const Right(false),
          );
        } else {
          final addResult = await repository.addToFavorites(zikrId);
          return addResult.fold(
            (failure) => Left(failure),
            (_) => const Right(true),
          );
        }
      },
    );
  }
}
