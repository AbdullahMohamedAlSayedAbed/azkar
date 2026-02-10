/// Zikr Details View
/// PageView for reading azkar one by one
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:azkar/injection_container.dart';
import 'package:azkar/core/constants/app_colors.dart';
import 'package:azkar/features/azkar/presentation/cubit/azkar_cubit.dart';
import 'package:azkar/features/azkar/domain/entities/zikr.dart';

class ZikrDetailsView extends StatelessWidget {
  final String category;
  final int initialIndex;

  const ZikrDetailsView({
    super.key,
    required this.category,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AzkarCubit>()..loadAzkar(category),
      child: _ZikrDetailsContent(initialIndex: initialIndex),
    );
  }
}

class _ZikrDetailsContent extends StatefulWidget {
  final int initialIndex;

  const _ZikrDetailsContent({required this.initialIndex});

  @override
  State<_ZikrDetailsContent> createState() => _ZikrDetailsContentState();
}

class _ZikrDetailsContentState extends State<_ZikrDetailsContent> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: BlocBuilder<AzkarCubit, AzkarState>(
          builder: (context, state) {
            if (state.status == AzkarStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.azkar.isEmpty) {
              return const Center(child: Text('لا توجد أذكار'));
            }

            return Stack(
              children: [
                // Background gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        theme.scaffoldBackgroundColor,
                        AppColors.primary.withValues(alpha: 0.05),
                      ],
                    ),
                  ),
                ),

                // Content
                SafeArea(
                  child: Column(
                    children: [
                      // App Bar
                      _buildAppBar(context, state),

                      // Page View
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: state.azkar.length,
                          onPageChanged: (index) {
                            context.read<AzkarCubit>().setCurrentIndex(index);
                          },
                          itemBuilder: (context, index) {
                            final zikr = state.azkar[index];
                            final remaining = state.getRemainingCount(
                                zikr.id, zikr.repeatCount);

                            return _buildZikrPage(
                                context, state, zikr, remaining, index);
                          },
                        ),
                      ),

                      // Bottom Navigation
                      _buildBottomNav(context, state),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, AzkarState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          Expanded(
            child: Text(
              '${state.currentIndex + 1} / ${state.totalAzkar}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          IconButton(
            onPressed: () => context.read<AzkarCubit>().resetProgress(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  Widget _buildZikrPage(BuildContext context, AzkarState state, Zikr zikr,
      int remaining, int index) {
    final theme = Theme.of(context);
    final isFavorite = state.isFavorite(zikr.id);
    final isCompleted = remaining == 0;

    return GestureDetector(
      onTap: () {
        if (!isCompleted) {
          HapticFeedback.lightImpact();
          context.read<AzkarCubit>().decrementCount(zikr.id);
        }
      },
      child: Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Actions Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () =>
                      context.read<AzkarCubit>().toggleFavorite(zikr.id),
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                ),
                IconButton(
                  onPressed: () => _copyToClipboard(context, zikr.text),
                  icon: const Icon(Icons.copy),
                ),
                IconButton(
                  onPressed: () => Share.share(zikr.text),
                  icon: const Icon(Icons.share),
                ),
              ],
            ),

            const Spacer(),

            // Zikr Text
            Expanded(
              flex: 3,
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Text(
                    zikr.text,
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 26.sp,
                      height: 2,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            // Note
            if (zikr.note != null) ...[
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  zikr.note!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.gold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16.h),
            ],

            // Reference
            if (zikr.reference != null)
              Text(
                zikr.reference!,
                style: theme.textTheme.labelMedium,
              ),

            const Spacer(),

            // Counter
            _buildCounter(context, remaining, isCompleted),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(BuildContext context, int remaining, bool isCompleted) {
    if (isCompleted) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 24.sp),
            SizedBox(width: 12.w),
            Text(
              'تم بحمد الله',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 20.h),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Text(
        remaining.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 36.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, AzkarState state) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Previous
          ElevatedButton.icon(
            onPressed: state.currentIndex > 0
                ? () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                : null,
            icon: const Icon(Icons.arrow_back_ios, size: 16),
            label: const Text('السابق'),
          ),

          // Progress Indicator
          SizedBox(
            width: 60.w,
            height: 60.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: state.progressPercentage,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  strokeWidth: 4,
                ),
                Text(
                  '${(state.progressPercentage * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Next
          ElevatedButton.icon(
            onPressed: state.currentIndex < state.azkar.length - 1
                ? () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                : null,
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
            label: const Text('التالي'),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم النسخ'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
