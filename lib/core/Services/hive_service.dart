/// Hive Storage Service
/// Handles local data persistence using Hive
library;

import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String settingsBox = 'settings';
  static const String azkarProgressBox = 'azkar_progress';
  static const String tasbeehBox = 'tasbeeh';
  static const String bookmarksBox = 'bookmarks';
  static const String favoritesBox = 'favorites';

  Future<void> init() async {
    await Hive.initFlutter();

    // Open boxes
    await Hive.openBox(settingsBox);
    await Hive.openBox(azkarProgressBox);
    await Hive.openBox(tasbeehBox);
    await Hive.openBox(bookmarksBox);
    await Hive.openBox(favoritesBox);
  }

  // Settings
  Box get settings => Hive.box(settingsBox);

  Future<void> saveSetting(String key, dynamic value) async {
    await settings.put(key, value);
  }

  T? getSetting<T>(String key, {T? defaultValue}) {
    return settings.get(key, defaultValue: defaultValue);
  }

  // Azkar Progress
  Box get azkarProgress => Hive.box(azkarProgressBox);

  Future<void> saveAzkarProgress(
      String categoryId, Map<String, int> progress) async {
    await azkarProgress.put(categoryId, progress);
  }

  Map<String, int>? getAzkarProgress(String categoryId) {
    final data = azkarProgress.get(categoryId);
    if (data != null) {
      return Map<String, int>.from(data);
    }
    return null;
  }

  Future<void> resetAzkarProgress(String categoryId) async {
    await azkarProgress.delete(categoryId);
  }

  // Tasbeeh
  Box get tasbeeh => Hive.box(tasbeehBox);

  Future<void> saveTasbeehCount(String preset, int count) async {
    await tasbeeh.put(preset, count);
  }

  int getTasbeehCount(String preset) {
    return tasbeeh.get(preset, defaultValue: 0);
  }

  Future<void> saveTotalTasbeeh(int total) async {
    await tasbeeh.put('total', total);
  }

  int getTotalTasbeeh() {
    return tasbeeh.get('total', defaultValue: 0);
  }

  // Bookmarks
  Box get bookmarks => Hive.box(bookmarksBox);

  Future<void> addBookmark(String type, String id) async {
    final List<String> current = getBookmarks(type);
    if (!current.contains(id)) {
      current.add(id);
      await bookmarks.put(type, current);
    }
  }

  Future<void> removeBookmark(String type, String id) async {
    final List<String> current = getBookmarks(type);
    current.remove(id);
    await bookmarks.put(type, current);
  }

  List<String> getBookmarks(String type) {
    final data = bookmarks.get(type);
    if (data != null) {
      return List<String>.from(data);
    }
    return [];
  }

  bool isBookmarked(String type, String id) {
    return getBookmarks(type).contains(id);
  }

  // Favorites
  Box get favorites => Hive.box(favoritesBox);

  Future<void> addFavorite(String type, String id) async {
    final List<String> current = getFavorites(type);
    if (!current.contains(id)) {
      current.add(id);
      await favorites.put(type, current);
    }
  }

  Future<void> removeFavorite(String type, String id) async {
    final List<String> current = getFavorites(type);
    current.remove(id);
    await favorites.put(type, current);
  }

  List<String> getFavorites(String type) {
    final data = favorites.get(type);
    if (data != null) {
      return List<String>.from(data);
    }
    return [];
  }

  bool isFavorite(String type, String id) {
    return getFavorites(type).contains(id);
  }

  // Clear all data
  Future<void> clearAll() async {
    await settings.clear();
    await azkarProgress.clear();
    await tasbeeh.clear();
    await bookmarks.clear();
    await favorites.clear();
  }
}
