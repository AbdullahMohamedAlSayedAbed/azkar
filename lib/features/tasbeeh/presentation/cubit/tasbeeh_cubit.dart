import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_tasbeeh_total.dart';
import '../../domain/usecases/save_tasbeeh_total.dart';

part 'tasbeeh_state.dart';

class TasbeehCubit extends Cubit<TasbeehState> {
  final GetTasbeehTotal getTasbeehTotal;
  final SaveTasbeehTotal saveTasbeehTotal;

  TasbeehCubit({
    required this.getTasbeehTotal,
    required this.saveTasbeehTotal,
  }) : super(const TasbeehState()) {
    _loadTotalCount();
  }

  Future<void> _loadTotalCount() async {
    final result = await getTasbeehTotal(NoParams());
    result.fold(
      (failure) {}, // Ignore failure for total count, default is 0
      (total) => emit(state.copyWith(totalCount: total)),
    );
  }

  Future<void> increment() async {
    final newCount = state.count + 1;
    final newTotal = state.totalCount + 1;

    emit(state.copyWith(count: newCount, totalCount: newTotal));

    // Save total
    await saveTasbeehTotal(newTotal);
  }

  void reset() {
    emit(state.copyWith(count: 0));
  }

  void setTarget(int target) {
    emit(state.copyWith(target: target, count: 0));
  }

  void setZikr(String zikr) {
    emit(state.copyWith(currentZikr: zikr, count: 0));
  }

  void toggleVibration() {
    emit(state.copyWith(vibrationEnabled: !state.vibrationEnabled));
  }

  void toggleSound() {
    emit(state.copyWith(soundEnabled: !state.soundEnabled));
  }

  // Preset azkar
  static const List<Map<String, dynamic>> presets = [
    {'zikr': 'سبحان الله', 'target': 33},
    {'zikr': 'الحمد لله', 'target': 33},
    {'zikr': 'الله أكبر', 'target': 34},
    {'zikr': 'لا إله إلا الله', 'target': 100},
    {'zikr': 'سبحان الله وبحمده', 'target': 100},
    {'zikr': 'أستغفر الله', 'target': 100},
    {'zikr': 'لا حول ولا قوة إلا بالله', 'target': 100},
  ];

  void selectPreset(int index) {
    if (index >= 0 && index < presets.length) {
      final preset = presets[index];
      emit(state.copyWith(
        currentZikr: preset['zikr'] as String,
        target: preset['target'] as int,
        count: 0,
      ));
    }
  }
}
