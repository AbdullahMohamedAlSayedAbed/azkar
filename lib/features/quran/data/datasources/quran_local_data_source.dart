import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../core/error/exceptions.dart';
import '../models/surah_model.dart';

abstract class QuranLocalDataSource {
  Future<List<SurahModel>> getSurahs();
}

class QuranLocalDataSourceImpl implements QuranLocalDataSource {
  @override
  Future<List<SurahModel>> getSurahs() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/quran.json');
      final List<dynamic> data = json.decode(response);
      return data.map((json) => SurahModel.fromJson(json)).toList();
    } catch (e) {
      throw CacheException('Failed to load Quran data');
    }
  }
}
