/// Qibla View
/// Compass-based Qibla direction finder
library;

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkar/injection_container.dart';
import 'package:azkar/core/constants/app_colors.dart';
import 'package:azkar/features/qibla/presentation/cubit/qibla_cubit.dart';

class QiblaView extends StatelessWidget {
  const QiblaView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<QiblaCubit>()..initialize(),
      child: const _QiblaContent(),
    );
  }
}

class _QiblaContent extends StatelessWidget {
  const _QiblaContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('اتجاه القبلة'),
        ),
        body: BlocBuilder<QiblaCubit, QiblaState>(
          builder: (context, state) {
            if (state.status == QiblaStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == QiblaStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 64.sp, color: AppColors.error),
                    SizedBox(height: 16.h),
                    Text('${state.errorMessage}',
                        style: theme.textTheme.titleMedium),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context.read<QiblaCubit>().initialize(),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            final cubit = context.read<QiblaCubit>();

            return Column(
              children: [
                SizedBox(height: 40.h),

                // Kaaba Icon
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    gradient: AppColors.goldGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gold.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.location_city,
                    size: 40.sp,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 16.h),

                Text(
                  'الكعبة المشرفة',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  cubit.formatDistance(state.distanceToKaaba),
                  style: theme.textTheme.labelMedium,
                ),

                SizedBox(height: 40.h),

                // Compass
                Expanded(
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Compass Background
                        AnimatedRotation(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          turns: -state.compassHeading / 360,
                          child: Container(
                            width: 300.w,
                            height: 300.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark ? AppColors.cardDark : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: CustomPaint(
                              painter: _CompassPainter(
                                isDark: isDark,
                              ),
                            ),
                          ),
                        ),

                        // Qibla Needle
                        AnimatedRotation(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          turns: (state.qiblaDirection - state.compassHeading) /
                              360,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 4.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              Icon(
                                Icons.arrow_upward,
                                size: 40.sp,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),

                        // Center Circle
                        Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.4),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.explore,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Direction Info
                Container(
                  margin: EdgeInsets.all(24.w),
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.cardDark : Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _InfoColumn(
                        label: 'اتجاه القبلة',
                        value: '${state.qiblaDirection.toStringAsFixed(0)}°',
                      ),
                      Container(
                        height: 40.h,
                        width: 1,
                        color: theme.dividerColor,
                      ),
                      _InfoColumn(
                        label: 'البوصلة',
                        value: '${state.compassHeading.toStringAsFixed(0)}°',
                      ),
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
}

class _InfoColumn extends StatelessWidget {
  final String label;
  final String value;

  const _InfoColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _CompassPainter extends CustomPainter {
  final bool isDark;

  _CompassPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw ticks
    final tickPaint = Paint()
      ..color = isDark ? Colors.white54 : Colors.black26
      ..strokeWidth = 2;

    for (int i = 0; i < 360; i += 30) {
      final angle = i * (math.pi / 180);
      final startRadius = radius - 20;
      final endRadius = radius - (i % 90 == 0 ? 40 : 30);

      final start = Offset(
        center.dx + startRadius * math.sin(angle),
        center.dy - startRadius * math.cos(angle),
      );
      final end = Offset(
        center.dx + endRadius * math.sin(angle),
        center.dy - endRadius * math.cos(angle),
      );

      canvas.drawLine(start, end, tickPaint);
    }

    // Draw cardinal directions
    final textStyle = TextStyle(
      color: isDark ? Colors.white : Colors.black87,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    final directions = ['N', 'E', 'S', 'W'];
    final directionAngles = [0, 90, 180, 270];

    for (int i = 0; i < 4; i++) {
      final angle = directionAngles[i] * (math.pi / 180);
      final textRadius = radius - 55;

      final textSpan = TextSpan(text: directions[i], style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final offset = Offset(
        center.dx + textRadius * math.sin(angle) - textPainter.width / 2,
        center.dy - textRadius * math.cos(angle) - textPainter.height / 2,
      );

      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
