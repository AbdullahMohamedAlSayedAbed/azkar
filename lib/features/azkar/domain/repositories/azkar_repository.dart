import 'package:dartz/dartz.dart';
import 'package:azkar/core/error/failures.dart';
import 'package:azkar/features/azkar/domain/entities/zikr.dart';

abstract class AzkarRepository {
  /// Get azkar by category (morning, evening, sleep, wakeup, afterPrayer, ruqyah)
  Future<Either<Failure, List<Zikr>>> getAzkarByCategory(String category);

  /// Get a single zikr by ID
  Future<Either<Failure, Zikr?>> getZikrById(String id);

  /// Get all available categories
  Future<Either<Failure, List<String>>> getCategories();

  /// Get progress for a category (map of zikrId -> remainingCount)
  Future<Either<Failure, Map<String, int>>> getCategoryProgress(
      String category);

  /// Save progress for a category
  Future<Either<Failure, void>> saveCategoryProgress(
      String category, Map<String, int> progress);

  /// Reset progress for a category
  Future<Either<Failure, void>> resetCategoryProgress(String category);

  /// Get favorite azkar
  Future<Either<Failure, List<Zikr>>> getFavoriteAzkar();

  /// Add zikr to favorites
  Future<Either<Failure, void>> addToFavorites(String zikrId);

  /// Remove zikr from favorites
  Future<Either<Failure, void>> removeFromFavorites(String zikrId);

  /// Check if zikr is favorite
  Future<Either<Failure, bool>> isFavorite(String zikrId);
}
