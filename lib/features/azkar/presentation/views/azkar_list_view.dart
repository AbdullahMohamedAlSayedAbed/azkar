/// Azkar List View
/// Displays list of azkar for a category with progress
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:azkar/injection_container.dart';
import 'package:azkar/core/constants/app_colors.dart';
import 'package:azkar/features/azkar/presentation/cubit/azkar_cubit.dart';
import 'package:azkar/features/azkar/presentation/widgets/zikr_card.dart';
import 'package:azkar/features/azkar/presentation/widgets/azkar_progress_header.dart';

class AzkarListView extends StatelessWidget {
  final String category;
  final String title;

  const AzkarListView({
    super.key,
    required this.category,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AzkarCubit>()..loadAzkar(category),
      child: _AzkarListContent(title: title),
    );
  }
}

class _AzkarListContent extends StatelessWidget {
  final String title;

  const _AzkarListContent({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            BlocBuilder<AzkarCubit, AzkarState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () => context.read<AzkarCubit>().resetProgress(),
                  icon: const Icon(Icons.refresh),
                  tooltip: 'إعادة',
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<AzkarCubit, AzkarState>(
          builder: (context, state) {
            if (state.status == AzkarStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.status == AzkarStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 64.sp, color: AppColors.error),
                    SizedBox(height: 16.h),
                    Text(
                      'حدث خطأ',
                      style: theme.textTheme.titleLarge,
                    ),
                    SizedBox(height: 8.h),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<AzkarCubit>().loadAzkar(state.category),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            if (state.azkar.isEmpty) {
              return Center(
                child: Text(
                  'لا توجد أذكار',
                  style: theme.textTheme.titleLarge,
                ),
              );
            }

            return Column(
              children: [
                // Progress Header
                AzkarProgressHeader(state: state),

                // Azkar List
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.azkar.length,
                    itemBuilder: (context, index) {
                      final zikr = state.azkar[index];
                      final remaining =
                          state.getRemainingCount(zikr.id, zikr.repeatCount);
                      final isFavorite = state.isFavorite(zikr.id);

                      return ZikrCard(
                        zikr: zikr,
                        remainingCount: remaining,
                        isFavorite: isFavorite,
                        onTap: () =>
                            context.read<AzkarCubit>().decrementCount(zikr.id),
                        onFavoriteToggle: () =>
                            context.read<AzkarCubit>().toggleFavorite(zikr.id),
                        onShare: () =>
                            _shareZikr(context, zikr.text, zikr.reference),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _shareZikr(BuildContext context, String text, String? reference) {
    final shareText = reference != null ? '$text\n\n$reference' : text;
    Share.share(shareText);
  }
}
