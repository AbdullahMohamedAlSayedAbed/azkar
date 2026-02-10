/// Home Duas Section Widget
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkar/core/constants/app_strings.dart';
import 'package:azkar/core/routes/app_router.dart';
import 'package:azkar/features/home/presentation/widgets/feature_card.dart';

class HomeDuasSection extends StatelessWidget {
  const HomeDuasSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 12.h),
          child: Text(
            'الأدعية',
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
                icon: Icons.attach_money,
                title: AppStrings.duaRizq,
                gradient: const LinearGradient(
                  colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
                ),
                onTap: () => Navigator.pushNamed(context, AppRouter.duas),
              ),
              FeatureCard(
                icon: Icons.healing,
                title: AppStrings.duaShifa,
                gradient: const LinearGradient(
                  colors: [Color(0xFFE53935), Color(0xFFEF5350)],
                ),
                onTap: () => Navigator.pushNamed(context, AppRouter.duas),
              ),
              FeatureCard(
                icon: Icons.flight,
                title: AppStrings.duaTravel,
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                ),
                onTap: () => Navigator.pushNamed(context, AppRouter.duas),
              ),
              FeatureCard(
                icon: Icons.sentiment_satisfied_alt,
                title: AppStrings.duaAnxiety,
                gradient: const LinearGradient(
                  colors: [Color(0xFF7B1FA2), Color(0xFFAB47BC)],
                ),
                onTap: () => Navigator.pushNamed(context, AppRouter.duas),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
