/// Zikr Model
/// Data layer model with JSON serialization
library;

import 'package:azkar/features/azkar/domain/entities/zikr.dart';

class ZikrModel extends Zikr {
  const ZikrModel({
    required super.id,
    required super.text,
    super.translation,
    super.transliteration,
    super.reference,
    super.note,
    required super.repeatCount,
    required super.category,
    required super.order,
  });

  factory ZikrModel.fromJson(Map<String, dynamic> json) {
    return ZikrModel(
      id: json['id'] as String,
      text: json['text'] as String,
      translation: json['translation'] as String?,
      transliteration: json['transliteration'] as String?,
      reference: json['reference'] as String?,
      note: json['note'] as String?,
      repeatCount: json['repeat'] as int? ?? 1,
      category: json['category'] as String,
      order: json['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'translation': translation,
      'transliteration': transliteration,
      'reference': reference,
      'note': note,
      'repeat': repeatCount,
      'category': category,
      'order': order,
    };
  }

  factory ZikrModel.fromEntity(Zikr zikr) {
    return ZikrModel(
      id: zikr.id,
      text: zikr.text,
      translation: zikr.translation,
      transliteration: zikr.transliteration,
      reference: zikr.reference,
      note: zikr.note,
      repeatCount: zikr.repeatCount,
      category: zikr.category,
      order: zikr.order,
    );
  }
}
