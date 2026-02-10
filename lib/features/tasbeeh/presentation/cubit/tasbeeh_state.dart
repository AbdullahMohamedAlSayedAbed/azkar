part of 'tasbeeh_cubit.dart';

class TasbeehState extends Equatable {
  final int count;
  final int target;
  final int totalCount;
  final String currentZikr;
  final bool vibrationEnabled;
  final bool soundEnabled;

  const TasbeehState({
    this.count = 0,
    this.target = 33,
    this.totalCount = 0,
    this.currentZikr = 'سبحان الله',
    this.vibrationEnabled = true,
    this.soundEnabled = true,
  });

  double get progress => count / target;
  bool get isCompleted => count >= target;

  TasbeehState copyWith({
    int? count,
    int? target,
    int? totalCount,
    String? currentZikr,
    bool? vibrationEnabled,
    bool? soundEnabled,
  }) {
    return TasbeehState(
      count: count ?? this.count,
      target: target ?? this.target,
      totalCount: totalCount ?? this.totalCount,
      currentZikr: currentZikr ?? this.currentZikr,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
    );
  }

  @override
  List<Object?> get props =>
      [count, target, totalCount, currentZikr, vibrationEnabled, soundEnabled];
}
