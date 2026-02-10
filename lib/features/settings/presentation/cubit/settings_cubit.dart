/// Settings Cubit
/// Manages app settings state including theme, language, and notifications
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SharedPreferences sharedPreferences;

  // Keys
  static const String _themeModeKey = 'theme_mode';
  static const String _localeKey = 'locale';
  static const String _notificationsEnabledKey = 'notifications_enabled';
  static const String _morningAzkarNotificationKey =
      'morning_azkar_notification';
  static const String _eveningAzkarNotificationKey =
      'evening_azkar_notification';
  static const String _prayerNotificationsKey = 'prayer_notifications';
  static const String _morningAzkarHourKey = 'morning_azkar_hour';
  static const String _morningAzkarMinuteKey = 'morning_azkar_minute';
  static const String _eveningAzkarHourKey = 'evening_azkar_hour';
  static const String _eveningAzkarMinuteKey = 'evening_azkar_minute';
  static const String _adhanSoundKey = 'adhan_sound';

  SettingsCubit({required this.sharedPreferences})
      : super(const SettingsState());

  void loadSettings() {
    emit(state.copyWith(status: SettingsStatus.loading));

    try {
      final themeModeIndex = sharedPreferences.getInt(_themeModeKey) ?? 0;
      final localeCode = sharedPreferences.getString(_localeKey) ?? 'ar';

      emit(state.copyWith(
        status: SettingsStatus.loaded,
        themeMode: ThemeMode.values[themeModeIndex],
        locale: Locale(localeCode),
        notificationsEnabled:
            sharedPreferences.getBool(_notificationsEnabledKey) ?? true,
        morningAzkarNotification:
            sharedPreferences.getBool(_morningAzkarNotificationKey) ?? true,
        eveningAzkarNotification:
            sharedPreferences.getBool(_eveningAzkarNotificationKey) ?? true,
        prayerNotifications:
            sharedPreferences.getBool(_prayerNotificationsKey) ?? true,
        morningAzkarHour: sharedPreferences.getInt(_morningAzkarHourKey) ?? 6,
        morningAzkarMinute:
            sharedPreferences.getInt(_morningAzkarMinuteKey) ?? 0,
        eveningAzkarHour: sharedPreferences.getInt(_eveningAzkarHourKey) ?? 17,
        eveningAzkarMinute:
            sharedPreferences.getInt(_eveningAzkarMinuteKey) ?? 0,
        adhanSound: sharedPreferences.getString(_adhanSoundKey) ?? 'makkah',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SettingsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await sharedPreferences.setInt(_themeModeKey, mode.index);
    emit(state.copyWith(themeMode: mode));
  }

  Future<void> toggleDarkMode() async {
    final newMode = state.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }

  Future<void> setLocale(Locale locale) async {
    await sharedPreferences.setString(_localeKey, locale.languageCode);
    emit(state.copyWith(locale: locale));
  }

  Future<void> toggleLanguage() async {
    final newLocale = state.isArabic ? const Locale('en') : const Locale('ar');
    await setLocale(newLocale);
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    await sharedPreferences.setBool(_notificationsEnabledKey, enabled);
    emit(state.copyWith(notificationsEnabled: enabled));
  }

  Future<void> setMorningAzkarNotification(bool enabled) async {
    await sharedPreferences.setBool(_morningAzkarNotificationKey, enabled);
    emit(state.copyWith(morningAzkarNotification: enabled));
  }

  Future<void> setEveningAzkarNotification(bool enabled) async {
    await sharedPreferences.setBool(_eveningAzkarNotificationKey, enabled);
    emit(state.copyWith(eveningAzkarNotification: enabled));
  }

  Future<void> setPrayerNotifications(bool enabled) async {
    await sharedPreferences.setBool(_prayerNotificationsKey, enabled);
    emit(state.copyWith(prayerNotifications: enabled));
  }

  Future<void> setMorningAzkarTime(int hour, int minute) async {
    await sharedPreferences.setInt(_morningAzkarHourKey, hour);
    await sharedPreferences.setInt(_morningAzkarMinuteKey, minute);
    emit(state.copyWith(morningAzkarHour: hour, morningAzkarMinute: minute));
  }

  Future<void> setEveningAzkarTime(int hour, int minute) async {
    await sharedPreferences.setInt(_eveningAzkarHourKey, hour);
    await sharedPreferences.setInt(_eveningAzkarMinuteKey, minute);
    emit(state.copyWith(eveningAzkarHour: hour, eveningAzkarMinute: minute));
  }

  Future<void> setAdhanSound(String sound) async {
    await sharedPreferences.setString(_adhanSoundKey, sound);
    emit(state.copyWith(adhanSound: sound));
  }
}
