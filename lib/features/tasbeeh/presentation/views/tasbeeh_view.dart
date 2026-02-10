/// Tasbeeh View
/// Electronic tasbeeh counter with presets
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkar/injection_container.dart';
import 'package:azkar/core/constants/app_colors.dart';
import 'package:azkar/features/tasbeeh/presentation/cubit/tasbeeh_cubit.dart';

class TasbeehView extends StatelessWidget {
  const TasbeehView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TasbeehCubit>(),
      child: const _TasbeehContent(),
    );
  }
}

class _TasbeehContent extends StatelessWidget {
  const _TasbeehContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المسبحة الإلكترونية'),
          actions: [
            BlocBuilder<TasbeehCubit, TasbeehState>(
              builder: (context, state) {
                return Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          context.read<TasbeehCubit>().toggleVibration(),
                      icon: Icon(
                        state.vibrationEnabled
                            ? Icons.vibration
                            : Icons.phone_android,
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          context.read<TasbeehCubit>().toggleSound(),
                      icon: Icon(
                        state.soundEnabled ? Icons.volume_up : Icons.volume_off,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<TasbeehCubit, TasbeehState>(
          builder: (context, state) {
            return Column(
              children: [
                // Current Zikr
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Text(
                    state.currentZikr,
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Counter Circle
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (state.vibrationEnabled) {
                        HapticFeedback.lightImpact();
                      }
                      context.read<TasbeehCubit>().increment();
                    },
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Progress Circle
                          SizedBox(
                            width: 250.w,
                            height: 250.w,
                            child: CircularProgressIndicator(
                              value: state.progress,
                              strokeWidth: 12.w,
                              backgroundColor:
                                  AppColors.primary.withValues(alpha: 0.2),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                state.isCompleted
                                    ? AppColors.goldLight
                                    : AppColors.primary,
                              ),
                            ),
                          ),

                          // Counter Container
                          Container(
                            width: 200.w,
                            height: 200.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: state.isCompleted
                                  ? AppColors.goldGradient
                                  : AppColors.primaryGradient,
                              boxShadow: [
                                BoxShadow(
                                  color: (state.isCompleted
                                          ? AppColors.gold
                                          : AppColors.primary)
                                      .withValues(alpha: 0.4),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.count.toString(),
                                  style: TextStyle(
                                    fontSize: 72.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'من ${state.target}',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Total Count
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.cardDark : Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'الإجمالي',
                            style: theme.textTheme.labelMedium,
                          ),
                          Text(
                            state.totalCount.toString(),
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 40.h,
                        width: 1,
                        color: theme.dividerColor,
                      ),
                      IconButton(
                        onPressed: () => context.read<TasbeehCubit>().reset(),
                        icon: Icon(Icons.refresh, size: 32.sp),
                        tooltip: 'إعادة',
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Presets
                SizedBox(
                  height: 50.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: TasbeehCubit.presets.length,
                    itemBuilder: (context, index) {
                      final preset = TasbeehCubit.presets[index];
                      final isSelected = state.currentZikr == preset['zikr'];

                      return GestureDetector(
                        onTap: () =>
                            context.read<TasbeehCubit>().selectPreset(index),
                        child: Container(
                          margin: EdgeInsets.only(left: 8.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            gradient:
                                isSelected ? AppColors.primaryGradient : null,
                            color: isSelected
                                ? null
                                : (isDark ? AppColors.cardDark : Colors.white),
                            borderRadius: BorderRadius.circular(25.r),
                            border: isSelected
                                ? null
                                : Border.all(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.3),
                                  ),
                          ),
                          child: Center(
                            child: Text(
                              preset['zikr'] as String,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : theme.textTheme.bodyMedium?.color,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 24.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
