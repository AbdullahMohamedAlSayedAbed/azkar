/// Zikr Card Widget
/// Displays a single zikr with counter functionality
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkar/core/constants/app_colors.dart';
import 'package:azkar/features/azkar/domain/entities/zikr.dart';

class ZikrCard extends StatelessWidget {
  final Zikr zikr;
  final int remainingCount;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onShare;

  const ZikrCard({
    super.key,
    required this.zikr,
    required this.remainingCount,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteToggle,
    this.onShare,
  });

  bool get isCompleted => remainingCount == 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        if (onTap != null && !isCompleted) {
          HapticFeedback.lightImpact();
          onTap!();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: isCompleted
              ? (isDark
                  ? AppColors.primaryDark.withValues(alpha: 0.3)
                  : AppColors.primary.withValues(alpha: 0.1))
              : theme.cardTheme.color,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: (isDark ? Colors.black : AppColors.primary)
                  .withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isCompleted ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Zikr Text
            Text(
              zikr.text,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 22.sp,
                height: 2,
                fontFamily: 'Amiri',
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 16.h),

            // Note if available
            if (zikr.note != null) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  zikr.note!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark ? AppColors.goldLight : AppColors.gold,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 12.h),
            ],

            // Reference
            if (zikr.reference != null)
              Text(
                zikr.reference!,
                style: theme.textTheme.labelMedium?.copyWith(
                  color:
                      theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),

            SizedBox(height: 16.h),

            // Counter and Actions Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Favorite Button
                IconButton(
                  onPressed: onFavoriteToggle,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : theme.iconTheme.color,
                  ),
                ),

                SizedBox(width: 12.w),

                // Counter
                _buildCounter(context),

                SizedBox(width: 12.w),

                // Share Button
                IconButton(
                  onPressed: onShare,
                  icon: Icon(
                    Icons.share,
                    color: theme.iconTheme.color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(BuildContext context) {
    final theme = Theme.of(context);

    if (isCompleted) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              'تم بحمد الله',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        remainingCount.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
