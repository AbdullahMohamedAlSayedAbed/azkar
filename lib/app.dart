import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:azkar/injection_container.dart';
import 'package:azkar/core/theme/app_theme.dart';
import 'package:azkar/core/routes/app_router.dart';
import 'package:azkar/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:azkar/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';

class AzkarApp extends StatelessWidget {
  const AzkarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<SettingsCubit>()..loadSettings()),
            BlocProvider(
                create: (_) => sl<PrayerTimesCubit>()..loadPrayerTimes()),
          ],
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'أذكار',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: state.themeMode,
                locale: state.locale,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('ar'),
                  Locale('en'),
                ],
                onGenerateRoute: AppRouter.onGenerateRoute,
                initialRoute: AppRouter.splash,
                builder: (context, widget) {
                  return Directionality(
                    textDirection: state.locale.languageCode == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: widget!,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
