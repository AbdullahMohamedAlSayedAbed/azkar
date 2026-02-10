/// Dependency Injection Container
/// Manages all app dependencies using GetIt
library;

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core Services
import 'package:azkar/core/services/hive_service.dart';
import 'package:azkar/core/services/notification_service.dart';
import 'package:azkar/core/services/location_service.dart';
import 'package:azkar/core/services/audio_service.dart';

// Cubits
import 'package:azkar/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:azkar/features/azkar/presentation/cubit/azkar_cubit.dart';
import 'package:azkar/features/azkar/domain/usecases/get_azkar_by_category.dart';
import 'package:azkar/features/azkar/domain/usecases/get_category_progress.dart';
import 'package:azkar/features/azkar/domain/usecases/save_category_progress.dart';
import 'package:azkar/features/azkar/domain/usecases/get_favorite_azkar.dart';
import 'package:azkar/features/azkar/domain/usecases/toggle_favorite_azkar.dart';
import 'package:azkar/features/tasbeeh/presentation/cubit/tasbeeh_cubit.dart';
import 'package:azkar/features/tasbeeh/domain/repositories/tasbeeh_repository.dart';
import 'package:azkar/features/tasbeeh/data/repositories/tasbeeh_repository_impl.dart';
import 'package:azkar/features/tasbeeh/domain/usecases/get_tasbeeh_total.dart';
import 'package:azkar/features/tasbeeh/domain/usecases/save_tasbeeh_total.dart';
import 'package:azkar/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'package:azkar/features/qibla/presentation/cubit/qibla_cubit.dart';
import 'package:azkar/features/qibla/data/repositories/qibla_repository_impl.dart';
import 'package:azkar/features/qibla/domain/repositories/qibla_repository.dart';
import 'package:azkar/features/qibla/domain/usecases/get_qibla_data.dart';

import 'package:azkar/features/prayer_times/data/datasources/prayer_times_data_source.dart';
import 'package:azkar/features/prayer_times/data/repositories/prayer_times_repository_impl.dart';
import 'package:azkar/features/prayer_times/domain/repositories/prayer_times_repository.dart';
import 'package:azkar/features/prayer_times/domain/usecases/get_prayer_times.dart';

// Repositories
import 'package:azkar/features/azkar/data/repositories/azkar_repository_impl.dart';
import 'package:azkar/features/azkar/domain/repositories/azkar_repository.dart';

import 'package:azkar/features/quran/data/datasources/quran_local_data_source.dart';
import 'package:azkar/features/quran/data/repositories/quran_repository_impl.dart';
import 'package:azkar/features/quran/domain/repositories/quran_repository.dart';
import 'package:azkar/features/quran/domain/usecases/get_surahs.dart';
import 'package:azkar/features/quran/presentation/bloc/quran_bloc.dart';
import 'package:azkar/features/duas/data/repositories/duas_repository_impl.dart';
import 'package:azkar/features/duas/domain/repositories/duas_repository.dart';
import 'package:azkar/features/duas/domain/usecases/get_duas_by_category.dart';
import 'package:azkar/features/duas/presentation/cubit/duas_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Core Services
  final hiveService = HiveService();
  await hiveService.init();
  sl.registerLazySingleton(() => hiveService);

  final notificationService = NotificationService();
  await notificationService.init();
  sl.registerLazySingleton(() => notificationService);
  sl.registerLazySingleton(() => LocationService());
  sl.registerLazySingleton(() => AppAudioService());

  // Repositories
  sl.registerLazySingleton<AzkarRepository>(
    () => AzkarRepositoryImpl(hiveService: sl()),
  );

  // Cubits
  sl.registerFactory(() => SettingsCubit(sharedPreferences: sl()));

  sl.registerFactory(() => AzkarCubit(
        getAzkarByCategory: sl(),
        getCategoryProgress: sl(),
        saveCategoryProgress: sl(),
        getFavoriteAzkar: sl(),
        toggleFavoriteAzkar: sl(),
      ));

  sl.registerLazySingleton(() => GetAzkarByCategory(sl()));
  sl.registerLazySingleton(() => GetCategoryProgress(sl()));
  sl.registerLazySingleton(() => SaveCategoryProgress(sl()));
  sl.registerLazySingleton(() => GetFavoriteAzkar(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteAzkar(sl()));

  sl.registerLazySingleton<TasbeehRepository>(
    () => TasbeehRepositoryImpl(hiveService: sl()),
  );
  sl.registerLazySingleton(() => GetTasbeehTotal(sl()));
  sl.registerLazySingleton(() => SaveTasbeehTotal(sl()));

  sl.registerFactory(() => TasbeehCubit(
        getTasbeehTotal: sl(),
        saveTasbeehTotal: sl(),
      ));

  // Prayer Times Feature
  sl.registerLazySingleton<PrayerTimesDataSource>(
    () => PrayerTimesDataSourceImpl(),
  );
  sl.registerLazySingleton<PrayerTimesRepository>(
    () => PrayerTimesRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton(() => GetPrayerTimes(sl()));

  sl.registerFactory(() => PrayerTimesCubit(
        locationService: sl(),
        getPrayerTimes: sl(),
        notificationService: sl(),
      ));

  sl.registerLazySingleton<QiblaRepository>(
    () => QiblaRepositoryImpl(locationService: sl()),
  );
  sl.registerLazySingleton(() => GetQiblaData(sl()));
  sl.registerFactory(() => QiblaCubit(getQiblaData: sl()));

  // Quran Feature
  sl.registerLazySingleton<QuranLocalDataSource>(
    () => QuranLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<QuranRepository>(
    () => QuranRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetSurahs(sl()));
  sl.registerFactory(() => QuranBloc(getSurahs: sl()));

  // Duas Feature
  sl.registerLazySingleton<DuasRepository>(() => DuasRepositoryImpl());
  sl.registerLazySingleton<GetDuasByCategory>(() => GetDuasByCategory(sl()));
  sl.registerFactory<DuasCubit>(() => DuasCubit(getDuasByCategory: sl()));
}
