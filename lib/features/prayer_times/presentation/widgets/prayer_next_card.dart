import 'package:azkar/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:azkar/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';

class PrayerNextCard extends StatelessWidget {
  final PrayerTimesState state;
  final PrayerTimesCubit cubit;

  const PrayerNextCard({super.key, required this.state, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.mosque, size: 48.sp, color: Colors.white),
          SizedBox(height: 16.h),
          Text(
            'الصلاة القادمة',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            cubit.getPrayerNameArabic(state.nextPrayer),
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          if (state.prayerTimes[state.nextPrayer] != null)
            Text(
              DateFormat.jm('ar').format(state.prayerTimes[state.nextPrayer]!),
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Text(
              cubit.formatDuration(state.timeUntilNextPrayer),
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
