import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/azkar_repository.dart';

class SaveCategoryProgress implements UseCase<void, SaveProgressParams> {
  final AzkarRepository repository;

  SaveCategoryProgress(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveProgressParams params) async {
    return await repository.saveCategoryProgress(
        params.category, params.progress);
  }
}

class SaveProgressParams extends Equatable {
  final String category;
  final Map<String, int> progress;

  const SaveProgressParams({required this.category, required this.progress});

  @override
  List<Object> get props => [category, progress];
}
