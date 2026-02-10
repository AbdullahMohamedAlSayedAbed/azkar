/// Azkar Repository Implementation
/// Data layer implementation of AzkarRepository
library;

import 'package:dartz/dartz.dart';
import 'package:azkar/core/error/failures.dart';
import 'package:azkar/core/services/hive_service.dart';
import 'package:azkar/features/azkar/data/datasources/azkar_local_datasource.dart';
import 'package:azkar/features/azkar/domain/entities/zikr.dart';
import 'package:azkar/features/azkar/domain/repositories/azkar_repository.dart';

class AzkarRepositoryImpl implements AzkarRepository {
  final HiveService hiveService;

  AzkarRepositoryImpl({required this.hiveService});

  @override
  Future<Either<Failure, List<Zikr>>> getAzkarByCategory(
      String category) async {
    try {
      final azkar = AzkarLocalDataSource.getByCategory(category);
      return Right(azkar);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Zikr?>> getZikrById(String id) async {
    try {
      for (final category in AzkarLocalDataSource.categories) {
        final azkar = AzkarLocalDataSource.getByCategory(category);
        for (final zikr in azkar) {
          if (zikr.id == id) {
            return Right(zikr);
          }
        }
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      return Right(AzkarLocalDataSource.categories);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, int>>> getCategoryProgress(
      String category) async {
    try {
      final progress = hiveService.getAzkarProgress(category) ?? {};
      return Right(progress);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveCategoryProgress(
      String category, Map<String, int> progress) async {
    try {
      await hiveService.saveAzkarProgress(category, progress);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetCategoryProgress(String category) async {
    try {
      await hiveService.resetAzkarProgress(category);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Zikr>>> getFavoriteAzkar() async {
    try {
      final favoriteIds = hiveService.getFavorites('azkar');
      final List<Zikr> favorites = [];

      for (final id in favoriteIds) {
        // We can't call getZikrById directly as it returns Either now
        // But since we are inside the repository, we can reuse logic or extract it
        // For simplicity, let's just duplicate the search logic or call internal helper
        // Calling public method:
        final result = await getZikrById(id);
        result.fold(
          (failure) {}, // Ignore failures for individual items
          (zikr) {
            if (zikr != null) favorites.add(zikr);
          },
        );
      }
      return Right(favorites);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addToFavorites(String zikrId) async {
    try {
      await hiveService.addFavorite('azkar', zikrId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(String zikrId) async {
    try {
      await hiveService.removeFavorite('azkar', zikrId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String zikrId) async {
    try {
      final isFav = hiveService.isFavorite('azkar', zikrId);
      return Right(isFav);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
