part of 'azkar_cubit.dart';

enum AzkarStatus { initial, loading, loaded, error }

class AzkarState extends Equatable {
  final AzkarStatus status;
  final List<Zikr> azkar;
  final Map<String, int> progress;
  final int currentIndex;
  final String category;
  final String? errorMessage;
  final Set<String> favorites;

  const AzkarState({
    this.status = AzkarStatus.initial,
    this.azkar = const [],
    this.progress = const {},
    this.currentIndex = 0,
    this.category = '',
    this.errorMessage,
    this.favorites = const {},
  });

  int get totalAzkar => azkar.length;

  int get completedAzkar {
    int count = 0;
    for (final zikr in azkar) {
      final remaining = progress[zikr.id] ?? zikr.repeatCount;
      if (remaining == 0) count++;
    }
    return count;
  }

  double get progressPercentage {
    if (totalAzkar == 0) return 0;
    return completedAzkar / totalAzkar;
  }

  bool get isCompleted => completedAzkar == totalAzkar;

  Zikr? get currentZikr {
    if (currentIndex >= 0 && currentIndex < azkar.length) {
      return azkar[currentIndex];
    }
    return null;
  }

  int getRemainingCount(String zikrId, int defaultCount) {
    return progress[zikrId] ?? defaultCount;
  }

  bool isFavorite(String zikrId) => favorites.contains(zikrId);

  AzkarState copyWith({
    AzkarStatus? status,
    List<Zikr>? azkar,
    Map<String, int>? progress,
    int? currentIndex,
    String? category,
    String? errorMessage,
    Set<String>? favorites,
  }) {
    return AzkarState(
      status: status ?? this.status,
      azkar: azkar ?? this.azkar,
      progress: progress ?? this.progress,
      currentIndex: currentIndex ?? this.currentIndex,
      category: category ?? this.category,
      errorMessage: errorMessage ?? this.errorMessage,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  List<Object?> get props => [
        status,
        azkar,
        progress,
        currentIndex,
        category,
        errorMessage,
        favorites,
      ];
}
