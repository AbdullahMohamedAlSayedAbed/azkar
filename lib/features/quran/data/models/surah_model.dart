import '../../domain/entities/surah.dart';

class SurahModel extends Surah {
  const SurahModel({
    required super.number,
    required super.name,
    required super.transliteration,
    required super.translation,
    required super.type,
    required super.totalVerses,
    required super.verses,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      number: json['number'],
      name: json['name'],
      transliteration: json['transliteration'],
      translation: json['translation'],
      type: json['type'],
      totalVerses: json['total_verses'],
      verses:
          (json['verses'] as List).map((v) => VerseModel.fromJson(v)).toList(),
    );
  }
}

class VerseModel extends Verse {
  const VerseModel({
    required super.id,
    required super.text,
    required super.translation,
  });

  factory VerseModel.fromJson(Map<String, dynamic> json) {
    return VerseModel(
      id: json['id'],
      text: json['text'],
      translation: json['translation'],
    );
  }
}
