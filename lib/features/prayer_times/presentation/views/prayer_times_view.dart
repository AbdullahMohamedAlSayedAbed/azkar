/// Prayer Times View
/// Displays prayer times with countdown
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:azkar/core/constants/app_colors.dart';
import 'package:azkar/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'package:azkar/features/prayer_times/presentation/widgets/prayer_next_card.dart';
import 'package:azkar/features/prayer_times/presentation/widgets/prayer_time_row.dart';

class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PrayerTimesContent();
  }
}

class _PrayerTimesContent extends StatelessWidget {
  const _PrayerTimesContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('مواقيت الصلاة'),
        actions: [
          IconButton(
            onPressed: () => context.read<PrayerTimesCubit>().loadPrayerTimes(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
        builder: (context, state) {
          if (state.status == PrayerTimesStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == PrayerTimesStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_off, size: 64.sp, color: AppColors.error),
                  SizedBox(height: 16.h),
                  Text('${state.errorMessage}',
                      style: theme.textTheme.titleMedium),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<PrayerTimesCubit>().loadPrayerTimes(),
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          final cubit = context.read<PrayerTimesCubit>();

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Next Prayer Card
                PrayerNextCard(state: state, cubit: cubit),

                // Location
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 16.sp,
                          color: theme.textTheme.labelMedium?.color),
                      SizedBox(width: 4.w),
                      Text(state.locationName,
                          style: theme.textTheme.labelMedium),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Prayer Times List
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      'fajr',
                      'sunrise',
                      'dhuhr',
                      'asr',
                      'maghrib',
                      'isha'
                    ].asMap().entries.map((entry) {
                      final prayer = entry.value;
                      final time = state.prayerTimes[prayer];
                      final isNext = prayer == state.nextPrayer;
                      final isCurrent = prayer == state.currentPrayer;
                      final icons = [
                        Icons.nights_stay,
                        Icons.wb_twilight,
                        Icons.wb_sunny,
                        Icons.sunny_snowing,
                        Icons.brightness_4,
                        Icons.dark_mode,
                      ];

                      return PrayerTimeRow(
                        name: cubit.getPrayerNameArabic(prayer),
                        time: time != null
                            ? DateFormat.jm('ar').format(time)
                            : '--:--',
                        icon: icons[entry.key],
                        isNext: isNext,
                        isCurrent: isCurrent,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
