part of 'settings_cubit.dart';

enum SettingsStatus { initial, loading, loaded, error }

class SettingsState extends Equatable {
  final SettingsStatus status;
  final ThemeMode themeMode;
  final Locale locale;
  final bool notificationsEnabled;
  final bool morningAzkarNotification;
  final bool eveningAzkarNotification;
  final bool prayerNotifications;
  final int morningAzkarHour;
  final int morningAzkarMinute;
  final int eveningAzkarHour;
  final int eveningAzkarMinute;
  final String adhanSound;
  final String? errorMessage;

  const SettingsState({
    this.status = SettingsStatus.initial,
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('ar'),
    this.notificationsEnabled = true,
    this.morningAzkarNotification = true,
    this.eveningAzkarNotification = true,
    this.prayerNotifications = true,
    this.morningAzkarHour = 6,
    this.morningAzkarMinute = 0,
    this.eveningAzkarHour = 17,
    this.eveningAzkarMinute = 0,
    this.adhanSound = 'makkah',
    this.errorMessage,
  });

  bool get isDarkMode => themeMode == ThemeMode.dark;
  bool get isArabic => locale.languageCode == 'ar';

  SettingsState copyWith({
    SettingsStatus? status,
    ThemeMode? themeMode,
    Locale? locale,
    bool? notificationsEnabled,
    bool? morningAzkarNotification,
    bool? eveningAzkarNotification,
    bool? prayerNotifications,
    int? morningAzkarHour,
    int? morningAzkarMinute,
    int? eveningAzkarHour,
    int? eveningAzkarMinute,
    String? adhanSound,
    String? errorMessage,
  }) {
    return SettingsState(
      status: status ?? this.status,
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      morningAzkarNotification:
          morningAzkarNotification ?? this.morningAzkarNotification,
      eveningAzkarNotification:
          eveningAzkarNotification ?? this.eveningAzkarNotification,
      prayerNotifications: prayerNotifications ?? this.prayerNotifications,
      morningAzkarHour: morningAzkarHour ?? this.morningAzkarHour,
      morningAzkarMinute: morningAzkarMinute ?? this.morningAzkarMinute,
      eveningAzkarHour: eveningAzkarHour ?? this.eveningAzkarHour,
      eveningAzkarMinute: eveningAzkarMinute ?? this.eveningAzkarMinute,
      adhanSound: adhanSound ?? this.adhanSound,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        themeMode,
        locale,
        notificationsEnabled,
        morningAzkarNotification,
        eveningAzkarNotification,
        prayerNotifications,
        morningAzkarHour,
        morningAzkarMinute,
        eveningAzkarHour,
        eveningAzkarMinute,
        adhanSound,
        errorMessage,
      ];
}
