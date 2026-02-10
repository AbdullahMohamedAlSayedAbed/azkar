/// Home Azkar Section Widget
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkar/core/constants/app_colors.dart';
import 'package:azkar/core/constants/app_strings.dart';
import 'package:azkar/core/routes/app_router.dart';
import 'package:azkar/features/home/presentation/widgets/feature_card.dart';

class HomeAzkarSection extends StatelessWidget {
  const HomeAzkarSection({super.key});

  void _navigateToAzkar(BuildContext context, String category, String title) {
    Navigator.pushNamed(
      context,
      AppRouter.azkarList,
      arguments: AzkarListArgs(category: category, title: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 12.h),
          child: Text(
            'الأذكار والعبادات',
            style: theme.textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
              childAspectRatio: 1.1,
            ),
            children: [
              FeatureCard(
                icon: Icons.wb_sunny,
                title: AppStrings.morningAzkar,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
                ),
                onTap: () => _navigateToAzkar(
                    context, 'morning', AppStrings.morningAzkar),
              ),
              FeatureCard(
                icon: Icons.nights_stay,
                title: AppStrings.eveningAzkar,
                gradient: const LinearGradient(
                  colors: [Color(0xFF5C6BC0), Color(0xFF7986CB)],
                ),
                onTap: () => _navigateToAzkar(
                    context, 'evening', AppStrings.eveningAzkar),
              ),
              FeatureCard(
                icon: Icons.bedtime,
                title: AppStrings.sleepAzkar,
                gradient: const LinearGradient(
                  colors: [Color(0xFF26A69A), Color(0xFF4DB6AC)],
                ),
                onTap: () =>
                    _navigateToAzkar(context, 'sleep', AppStrings.sleepAzkar),
              ),
              FeatureCard(
                icon: Icons.alarm,
                title: AppStrings.wakeUpAzkar,
                gradient: const LinearGradient(
                  colors: [Color(0xFFEC407A), Color(0xFFF48FB1)],
                ),
                onTap: () =>
                    _navigateToAzkar(context, 'wakeup', AppStrings.wakeUpAzkar),
              ),
              FeatureCard(
                icon: Icons.mosque,
                title: AppStrings.afterPrayerAzkar,
                gradient: const LinearGradient(
                  colors: [Color(0xFF8E24AA), Color(0xFFBA68C8)],
                ),
                onTap: () => _navigateToAzkar(
                    context, 'afterPrayer', AppStrings.afterPrayerAzkar),
              ),
              FeatureCard(
                icon: Icons.radio_button_checked,
                title: AppStrings.electronicTasbeeh,
                gradient: AppColors.primaryGradient,
                onTap: () => Navigator.pushNamed(context, AppRouter.tasbeeh),
              ),
              FeatureCard(
                icon: Icons.auto_awesome,
                title: AppStrings.allahNames,
                gradient: const LinearGradient(
                  colors: [AppColors.gold, AppColors.goldLight],
                ),
                onTap: () => Navigator.pushNamed(context, AppRouter.allahNames),
              ),
              FeatureCard(
                icon: Icons.menu_book,
                title: AppStrings.ruqyah,
                gradient: const LinearGradient(
                  colors: [Color(0xFF00897B), Color(0xFF4DB6AC)],
                ),
                onTap: () =>
                    _navigateToAzkar(context, 'ruqyah', AppStrings.ruqyah),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
