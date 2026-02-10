/// Home View
/// Main screen with feature grid navigation
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkar/core/routes/app_router.dart';
import 'package:azkar/features/home/presentation/widgets/greeting_header.dart';
import 'package:azkar/features/home/presentation/widgets/home_quick_actions.dart';
import 'package:azkar/features/home/presentation/widgets/home_azkar_section.dart';
import 'package:azkar/features/home/presentation/widgets/home_duas_section.dart';
import 'package:azkar/features/home/presentation/widgets/home_bottom_nav.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header
            const SliverToBoxAdapter(
              child: GreetingHeader(),
            ),

            // Quick Actions
            const SliverToBoxAdapter(
              child: HomeQuickActions(),
            ),

            // Azkar Section
            const SliverToBoxAdapter(
              child: HomeAzkarSection(),
            ),

            // Duas Section
            const SliverToBoxAdapter(
              child: HomeDuasSection(),
            ),

            // Bottom Padding
            SliverToBoxAdapter(
              child: SizedBox(height: 100.h),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: const HomeBottomNav(),

      // Settings FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRouter.settings),
        child: const Icon(Icons.settings),
      ),
    );
  }
}
