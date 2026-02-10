/// Hijri Calendar View
/// Placeholder for Hijri calendar feature
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:azkar/core/constants/app_colors.dart';

class HijriCalendarView extends StatelessWidget {
  const HijriCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hijriDate = HijriCalendar.now();
    final gregorianDate = DateTime.now();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('التقويم الهجري'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // Date Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  gradient: isDark
                      ? AppColors.darkGradient
                      : AppColors.primaryGradient,
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
                  children: [
                    Text(
                      hijriDate.hYear.toString(),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      hijriDate.longMonthName,
                      style: TextStyle(
                        color: AppColors.goldLight,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    Text(
                      hijriDate.hDay.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 64.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      hijriDate.dayWeName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        DateFormat('dd MMMM yyyy').format(gregorianDate),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // Placeholder for monthly view
              _buildMonthGrid(context, hijriDate),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthGrid(BuildContext context, HijriCalendar date) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أحداث هامة في شهر ${date.longMonthName}',
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.h),
        _buildEventTile(context, 'بداية الشهر', '1 ${date.longMonthName}'),
        _buildEventTile(
            context, 'الأيام البيض', '13, 14, 15 ${date.longMonthName}'),
      ],
    );
  }

  Widget _buildEventTile(BuildContext context, String title, String date) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontFamily: 'Cairo')),
          Text(date,
              style: const TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
