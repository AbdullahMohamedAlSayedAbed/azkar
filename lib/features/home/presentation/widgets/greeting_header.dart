/// Greeting Header Widget
/// Shows time-based greeting and next prayer info
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:azkar/core/constants/app_colors.dart';
import 'package:azkar/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'package:azkar/features/home/presentation/widgets/next_prayer_card.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final greeting = _getGreeting();

    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
        builder: (context, state) {
      return Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.darkGradient : AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    greeting.icon,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        greeting.text,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _getIslamicDate(),
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14.sp,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            // Next Prayer Info
            NextPrayerCard(state: state),

            SizedBox(height: 16.h),

            // Daily Reminder
            Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: AppColors.goldLight,
                  size: 18.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'اللهم إني أسألك العفو والعافية في الدنيا والآخرة',
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 14.sp,
                      color: Colors.white.withValues(alpha: 0.9),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  _Greeting _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return const _Greeting(
        text: 'صباح الخير',
        icon: Icons.wb_sunny,
      );
    } else if (hour >= 12 && hour < 17) {
      return const _Greeting(
        text: 'مساء الخير',
        icon: Icons.wb_twilight,
      );
    } else if (hour >= 17 && hour < 21) {
      return const _Greeting(
        text: 'مساء النور',
        icon: Icons.nights_stay,
      );
    } else {
      return const _Greeting(
        text: 'تصبح على خير',
        icon: Icons.bedtime,
      );
    }
  }

  String _getIslamicDate() {
    final today = HijriCalendar.now();
    return '${today.dayWeName}، ${today.hDay} ${today.longMonthName} ${today.hYear}';
  }
}

class _Greeting {
  final String text;
  final IconData icon;

  const _Greeting({required this.text, required this.icon});
}
