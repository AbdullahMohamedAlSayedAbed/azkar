import 'package:equatable/equatable.dart';

class QiblaData extends Equatable {
  final double direction;
  final double distance;

  const QiblaData({
    required this.direction,
    required this.distance,
  });

  @override
  List<Object?> get props => [direction, distance];
}
