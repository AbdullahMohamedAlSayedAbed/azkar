import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/zikr.dart';
import '../../domain/usecases/get_azkar_by_category.dart';
import '../../domain/usecases/get_category_progress.dart';
import '../../domain/usecases/save_category_progress.dart';
import '../../domain/usecases/get_favorite_azkar.dart';
import '../../domain/usecases/toggle_favorite_azkar.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  final GetAzkarByCategory getAzkarByCategory;
  final GetCategoryProgress getCategoryProgress;
  final SaveCategoryProgress saveCategoryProgress;
  final GetFavoriteAzkar getFavoriteAzkar;
  final ToggleFavoriteAzkar toggleFavoriteAzkar;

  AzkarCubit({
    required this.getAzkarByCategory,
    required this.getCategoryProgress,
    required this.saveCategoryProgress,
    required this.getFavoriteAzkar,
    required this.toggleFavoriteAzkar,
  }) : super(const AzkarState());

  /// Load azkar by category
  Future<void> loadAzkar(String category) async {
    emit(state.copyWith(status: AzkarStatus.loading, category: category));

    final azkarResult = await getAzkarByCategory(category);
    final progressResult = await getCategoryProgress(category);

    // We handle favorites loading separately or here?
    // To minimize complexity, let's just create an empty set or try to load them if needed.
    // For now, let's load favorites to check status
    final favoritesResult = await getFavoriteAzkar(NoParams());
    Set<String> favorites = {};
    favoritesResult.fold(
        (_) {}, (favs) => favorites = favs.map((z) => z.id).toSet());

    azkarResult.fold(
      (failure) => emit(state.copyWith(
        status: AzkarStatus.error,
        errorMessage: failure.message,
      )),
      (azkar) {
        progressResult.fold(
            (failure) => emit(state.copyWith(
                  status: AzkarStatus.error,
                  errorMessage:
                      failure.message, // Or maybe show cached azkar with error?
                )), (progress) {
          // Initialize progress for new azkar
          final Map<String, int> initializedProgress = {};
          for (final zikr in azkar) {
            initializedProgress[zikr.id] =
                progress[zikr.id] ?? zikr.repeatCount;
          }

          emit(state.copyWith(
            status: AzkarStatus.loaded,
            azkar: azkar,
            progress: initializedProgress,
            currentIndex: 0,
            favorites: favorites,
          ));
        });
      },
    );
  }

  /// Decrement repeat count for a zikr
  Future<void> decrementCount(String zikrId) async {
    final currentCount = state.progress[zikrId] ?? 0;
    if (currentCount <= 0) return;

    final newProgress = Map<String, int>.from(state.progress);
    newProgress[zikrId] = currentCount - 1;

    emit(state.copyWith(progress: newProgress));

    final result = await saveCategoryProgress(
        SaveProgressParams(category: state.category, progress: newProgress));

    result.fold((failure) {
      // Optionally handle save failure (e.g. show toast)
    }, (_) {});

    // Auto-advance to next zikr if completed
    if (newProgress[zikrId] == 0) {
      _autoAdvance();
    }
  }

  /// Auto-advance to next incomplete zikr
  void _autoAdvance() {
    for (int i = state.currentIndex + 1; i < state.azkar.length; i++) {
      final zikr = state.azkar[i];
      final remaining = state.progress[zikr.id] ?? zikr.repeatCount;
      if (remaining > 0) {
        emit(state.copyWith(currentIndex: i));
        return;
      }
    }
  }

  /// Set current index
  void setCurrentIndex(int index) {
    if (index >= 0 && index < state.azkar.length) {
      emit(state.copyWith(currentIndex: index));
    }
  }

  /// Go to next zikr
  void nextZikr() {
    if (state.currentIndex < state.azkar.length - 1) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    }
  }

  /// Go to previous zikr
  void previousZikr() {
    if (state.currentIndex > 0) {
      emit(state.copyWith(currentIndex: state.currentIndex - 1));
    }
  }

  /// Reset all progress for current category
  Future<void> resetProgress() async {
    final Map<String, int> resetProgress = {};
    for (final zikr in state.azkar) {
      resetProgress[zikr.id] = zikr.repeatCount;
    }

    emit(state.copyWith(progress: resetProgress, currentIndex: 0));

    await saveCategoryProgress(
        SaveProgressParams(category: state.category, progress: resetProgress));
  }

  /// Toggle favorite
  Future<void> toggleFavorite(String zikrId) async {
    final result = await toggleFavoriteAzkar(zikrId);

    result.fold(
        (failure) =>
            emit(state.copyWith(errorMessage: failure.message)), // Show error?
        (isFavorite) {
      final newFavorites = Set<String>.from(state.favorites);
      if (isFavorite) {
        newFavorites.add(zikrId);
      } else {
        newFavorites.remove(zikrId);
      }
      emit(state.copyWith(favorites: newFavorites));
    });
  }

  /// Load favorite azkar only
  Future<void> loadFavorites() async {
    emit(state.copyWith(status: AzkarStatus.loading, category: 'favorites'));

    final result = await getFavoriteAzkar(NoParams());

    result.fold(
        (failure) => emit(state.copyWith(
              status: AzkarStatus.error,
              errorMessage: failure.message,
            )), (azkar) {
      final favorites = azkar.map((z) => z.id).toSet();
      emit(state.copyWith(
        status: AzkarStatus.loaded,
        azkar: azkar,
        progress: {}, // No progress for favorites list view usually? Or we track it?
        // Existing logic had invalid progress initialization likely.
        // Let's assume progress tracking is not primary for favorites list unless we play them.
        // But for consistency:
        currentIndex: 0,
        favorites: favorites,
      ));
    });
  }
}
