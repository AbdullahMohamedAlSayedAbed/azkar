part of 'qibla_cubit.dart';

enum QiblaStatus { initial, loading, loaded, error }

class QiblaState extends Equatable {
  final QiblaStatus status;
  final double compassHeading;
  final double qiblaDirection;
  final double distanceToKaaba;
  final String? errorMessage;

  const QiblaState({
    this.status = QiblaStatus.initial,
    this.compassHeading = 0,
    this.qiblaDirection = 0,
    this.distanceToKaaba = 0,
    this.errorMessage,
  });

  QiblaState copyWith({
    QiblaStatus? status,
    double? compassHeading,
    double? qiblaDirection,
    double? distanceToKaaba,
    String? errorMessage,
  }) {
    return QiblaState(
      status: status ?? this.status,
      compassHeading: compassHeading ?? this.compassHeading,
      qiblaDirection: qiblaDirection ?? this.qiblaDirection,
      distanceToKaaba: distanceToKaaba ?? this.distanceToKaaba,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        compassHeading,
        qiblaDirection,
        distanceToKaaba,
        errorMessage,
      ];
}
