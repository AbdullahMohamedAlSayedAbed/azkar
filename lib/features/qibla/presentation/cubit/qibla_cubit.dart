/// Qibla Cubit
/// Manages Qibla direction state with compass integration
library;

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:equatable/equatable.dart';
import 'package:azkar/core/usecases/usecase.dart';
import '../../domain/usecases/get_qibla_data.dart';

part 'qibla_state.dart';

class QiblaCubit extends Cubit<QiblaState> {
  final GetQiblaData getQiblaData;
  StreamSubscription<CompassEvent>? _compassSubscription;

  QiblaCubit({required this.getQiblaData}) : super(const QiblaState());

  Future<void> initialize() async {
    emit(state.copyWith(status: QiblaStatus.loading));

    try {
      final result = await getQiblaData(NoParams());

      result.fold(
        (failure) => emit(state.copyWith(
          status: QiblaStatus.error,
          errorMessage: failure.message,
        )),
        (data) {
          emit(state.copyWith(
            status: QiblaStatus.loaded,
            qiblaDirection: data.direction,
            distanceToKaaba: data.distance,
          ));
          _startCompass();
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: QiblaStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _startCompass() {
    _compassSubscription = FlutterCompass.events?.listen((event) {
      if (event.heading != null) {
        emit(state.copyWith(compassHeading: event.heading!));
      }
    });
  }

  String formatDistance(double meters) {
    if (meters >= 1000) {
      return '${(meters / 1000).toStringAsFixed(0)} كم';
    }
    return '${meters.toStringAsFixed(0)} م';
  }

  @override
  Future<void> close() {
    _compassSubscription?.cancel();
    return super.close();
  }
}
