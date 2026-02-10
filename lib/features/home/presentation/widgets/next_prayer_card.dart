import 'package:azkar/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:azkar/features/prayer_times/presentation/cubit/prayer_times_cubit.dart';

class NextPrayerCard extends StatelessWidget {
  final PrayerTimesState state;

  const NextPrayerCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.status == PrayerTimesStatus.loading) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.white));
    }

    if (state.nextPrayer.isEmpty) {
      return const SizedBox.shrink();
    }

    final cubit = context.read<PrayerTimesCubit>();
    final nextPrayerTime = state.prayerTimes[state.nextPrayer];
    final timeString = nextPrayerTime != null
        ? DateFormat('hh:mm a').format(nextPrayerTime)
        : '--:--';

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.access_time,
            color: Colors.white,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الصلاة القادمة',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                Text(
                  '${cubit.getPrayerNameArabic(state.nextPrayer)} - $timeString',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              cubit.formatDuration(state.timeUntilNextPrayer),
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
