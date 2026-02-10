/// Home Quick Actions Widget
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkar/core/constants/app_colors.dart';
import 'package:azkar/core/routes/app_router.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: _QuickActionCard(
              icon: Icons.menu_book,
              label: 'القرآن',
              onTap: () => Navigator.pushNamed(context, AppRouter.quran),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _QuickActionCard(
              icon: Icons.access_time,
              label: 'الصلاة',
              onTap: () => Navigator.pushNamed(context, AppRouter.prayerTimes),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _QuickActionCard(
              icon: Icons.explore,
              label: 'القبلة',
              onTap: () => Navigator.pushNamed(context, AppRouter.qibla),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _QuickActionCard(
              icon: Icons.calendar_today,
              label: 'التقويم',
              onTap: () => Navigator.pushNamed(context, AppRouter.calendar),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 24.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
