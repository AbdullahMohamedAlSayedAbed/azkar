import 'package:equatable/equatable.dart';

class Surah extends Equatable {
  final int number;
  final String name;
  final String transliteration;
  final String translation;
  final String type;
  final int totalVerses;
  final List<Verse> verses;

  const Surah({
    required this.number,
    required this.name,
    required this.transliteration,
    required this.translation,
    required this.type,
    required this.totalVerses,
    required this.verses,
  });

  @override
  List<Object?> get props =>
      [number, name, transliteration, translation, type, totalVerses, verses];
}

class Verse extends Equatable {
  final int id;
  final String text;
  final String translation;

  const Verse({
    required this.id,
    required this.text,
    required this.translation,
  });

  @override
  List<Object?> get props => [id, text, translation];
}
