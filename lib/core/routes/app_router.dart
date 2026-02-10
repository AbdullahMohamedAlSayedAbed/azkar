/// App Router
/// Handles all app navigation and routing
library;

import 'package:flutter/material.dart';

// Feature Views
import 'package:azkar/features/splash/presentation/views/splash_view.dart';
import 'package:azkar/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:azkar/features/home/presentation/views/home_view.dart';
import 'package:azkar/features/azkar/presentation/views/azkar_list_view.dart';
import 'package:azkar/features/azkar/presentation/views/zikr_details_view.dart';
import 'package:azkar/features/tasbeeh/presentation/views/tasbeeh_view.dart';
import 'package:azkar/features/prayer_times/presentation/views/prayer_times_view.dart';
import 'package:azkar/features/qibla/presentation/views/qibla_view.dart';
import 'package:azkar/features/hijri_calendar/presentation/views/calendar_view.dart';
import 'package:azkar/features/duas/presentation/views/duas_categories_view.dart';
import 'package:azkar/features/settings/presentation/views/settings_view.dart';
import 'package:azkar/features/allah_names/presentation/views/allah_names_view.dart';
import 'package:azkar/features/quran/presentation/views/quran_view.dart';
import 'package:azkar/features/quran/presentation/views/surah_detail_view.dart';
import 'package:azkar/features/duas/presentation/views/duas_list_view.dart';

class AppRouter {
  AppRouter._();

  // Route Names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String azkarList = '/azkar';
  static const String zikrDetails = '/azkar/details';
  static const String tasbeeh = '/tasbeeh';
  static const String prayerTimes = '/prayer-times';
  static const String qibla = '/qibla';
  static const String calendar = '/calendar';
  static const String duas = '/duas';
  static const String duaDetails = '/duas/details';
  static const String duasList = '/duas/list';
  static const String quran = '/quran';
  static const String surah = '/quran/surah';
  static const String settings = '/settings';
  static const String allahNames = '/allah-names';
  static const String prophetNames = '/prophet-names';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashView());

      case onboarding:
        return _buildRoute(const OnboardingView());

      case home:
        return _buildRoute(const HomeView());

      case azkarList:
        final args = settings.arguments as AzkarListArgs?;
        return _buildRoute(AzkarListView(
          category: args?.category ?? 'morning',
          title: args?.title ?? 'أذكار',
        ));

      case zikrDetails:
        final args = settings.arguments as ZikrDetailsArgs;
        return _buildRoute(ZikrDetailsView(
          category: args.category,
          initialIndex: args.initialIndex,
        ));

      case tasbeeh:
        return _buildRoute(const TasbeehView());

      case prayerTimes:
        return _buildRoute(const PrayerTimesView());

      case qibla:
        return _buildRoute(const QiblaView());

      case calendar:
        return _buildRoute(const HijriCalendarView());

      case duas:
        return _buildRoute(const DuasCategoriesView());

      case duasList:
        final args = settings.arguments as DuasListArgs;
        return _buildRoute(DuasListView(
          category: args.category,
          title: args.title,
        ));

      case AppRouter.settings:
        return _buildRoute(const SettingsView());

      case AppRouter.allahNames:
        return _buildRoute(const AllahNamesView());

      case AppRouter.quran:
        return _buildRoute(const QuranView());

      case AppRouter.surah:
        final args = settings.arguments as SurahArgs;
        return _buildRoute(SurahDetailView(
          surahNumber: args.surahNumber,
          surahName: args.surahName,
        ));

      default:
        return _buildRoute(const HomeView());
    }
  }

  static MaterialPageRoute _buildRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }

  // Navigation Helpers
  static Future<void> navigateTo(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static Future<void> navigateAndReplace(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.pushReplacementNamed(context, routeName,
        arguments: arguments);
  }

  static Future<void> navigateAndClearStack(
      BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.pushNamedAndRemoveUntil(
        context, routeName, (route) => false,
        arguments: arguments);
  }

  static void pop(BuildContext context, [dynamic result]) {
    Navigator.pop(context, result);
  }
}

// Route Arguments Classes
class AzkarListArgs {
  final String category;
  final String title;

  const AzkarListArgs({required this.category, required this.title});
}

class ZikrDetailsArgs {
  final String category;
  final int initialIndex;

  const ZikrDetailsArgs({required this.category, this.initialIndex = 0});
}

class SurahArgs {
  final int surahNumber;
  final String surahName;

  const SurahArgs({required this.surahNumber, required this.surahName});
}

class DuasListArgs {
  final String category;
  final String title;

  const DuasListArgs({required this.category, required this.title});
}
