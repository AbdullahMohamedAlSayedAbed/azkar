import '../../domain/entities/dua.dart';

class DuaModel extends Dua {
  const DuaModel({
    required super.id,
    required super.text,
    super.translation,
    super.reference,
    required super.category,
  });

  factory DuaModel.fromJson(Map<String, dynamic> json) {
    return DuaModel(
      id: json['id'],
      text: json['text'],
      translation: json['translation'],
      reference: json['reference'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'translation': translation,
      'reference': reference,
      'category': category,
    };
  }
}
