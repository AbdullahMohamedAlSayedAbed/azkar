/// Zikr Entity
/// Domain layer entity for a single zikr
library;

import 'package:equatable/equatable.dart';

class Zikr extends Equatable {
  final String id;
  final String text;
  final String? translation;
  final String? transliteration;
  final String? reference;
  final String? note;
  final int repeatCount;
  final String category;
  final int order;

  const Zikr({
    required this.id,
    required this.text,
    this.translation,
    this.transliteration,
    this.reference,
    this.note,
    required this.repeatCount,
    required this.category,
    required this.order,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        translation,
        transliteration,
        reference,
        note,
        repeatCount,
        category,
        order
      ];
}
