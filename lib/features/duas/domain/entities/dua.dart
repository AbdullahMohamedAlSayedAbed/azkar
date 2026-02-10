import 'package:equatable/equatable.dart';

class Dua extends Equatable {
  final String id;
  final String text;
  final String? translation;
  final String? reference;
  final String category;

  const Dua({
    required this.id,
    required this.text,
    this.translation,
    this.reference,
    required this.category,
  });

  @override
  List<Object?> get props => [id, text, translation, reference, category];
}
