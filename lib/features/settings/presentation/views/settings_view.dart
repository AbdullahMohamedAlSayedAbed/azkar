/// Settings View
/// App settings with theme, language, and notifications
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkar/core/constants/app_colors.dart';
import 'package:azkar/features/settings/presentation/cubit/settings_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الإعدادات'),
        ),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                // Appearance Section
                const _SectionHeader(title: 'المظهر'),
                _SettingsCard(
                  children: [
                    _SwitchTile(
                      icon: Icons.dark_mode,
                      title: 'الوضع الليلي',
                      subtitle: 'تفعيل المظهر الداكن',
                      value: state.isDarkMode,
                      onChanged: (_) =>
                          context.read<SettingsCubit>().toggleDarkMode(),
                    ),
                    const Divider(),
                    _SwitchTile(
                      icon: Icons.language,
                      title: 'اللغة الإنجليزية',
                      subtitle: state.isArabic ? 'العربية' : 'English',
                      value: !state.isArabic,
                      onChanged: (_) =>
                          context.read<SettingsCubit>().toggleLanguage(),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Notifications Section
                const _SectionHeader(title: 'الإشعارات'),
                _SettingsCard(
                  children: [
                    _SwitchTile(
                      icon: Icons.notifications,
                      title: 'الإشعارات',
                      subtitle: 'تفعيل جميع الإشعارات',
                      value: state.notificationsEnabled,
                      onChanged: (v) => context
                          .read<SettingsCubit>()
                          .setNotificationsEnabled(v),
                    ),
                    const Divider(),
                    _SwitchTile(
                      icon: Icons.wb_sunny,
                      title: 'أذكار الصباح',
                      subtitle: 'تنبيه يومي للأذكار الصباحية',
                      value: state.morningAzkarNotification,
                      onChanged: (v) => context
                          .read<SettingsCubit>()
                          .setMorningAzkarNotification(v),
                    ),
                    const Divider(),
                    _SwitchTile(
                      icon: Icons.nights_stay,
                      title: 'أذكار المساء',
                      subtitle: 'تنبيه يومي للأذكار المسائية',
                      value: state.eveningAzkarNotification,
                      onChanged: (v) => context
                          .read<SettingsCubit>()
                          .setEveningAzkarNotification(v),
                    ),
                    const Divider(),
                    _SwitchTile(
                      icon: Icons.mosque,
                      title: 'مواقيت الصلاة',
                      subtitle: 'تنبيه قبل كل صلاة',
                      value: state.prayerNotifications,
                      onChanged: (v) => context
                          .read<SettingsCubit>()
                          .setPrayerNotifications(v),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // About Section
                const _SectionHeader(title: 'حول التطبيق'),
                _SettingsCard(
                  children: [
                    _ListTile(
                      icon: Icons.info_outline,
                      title: 'عن التطبيق',
                      subtitle: 'الإصدار 2.0.0',
                      onTap: () => _showAboutDialog(context),
                    ),
                    const Divider(),
                    _ListTile(
                      icon: Icons.star_outline,
                      title: 'تقييم التطبيق',
                      subtitle: 'ساعدنا بتقييمك',
                      onTap: () {},
                    ),
                    const Divider(),
                    _ListTile(
                      icon: Icons.share_outlined,
                      title: 'مشاركة التطبيق',
                      subtitle: 'شارك التطبيق مع أصدقائك',
                      onTap: () {},
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

                // App Logo/Footer
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.mosque,
                        size: 48.sp,
                        color: AppColors.primary.withValues(alpha: 0.5),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'أذكار',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary.withValues(alpha: 0.5),
                        ),
                      ),
                      Text(
                        'ذِكْرُ اللهِ حَياةُ القُلوب',
                        style: TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 14.sp,
                          color: theme.textTheme.labelMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('عن التطبيق'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('أذكار - تطبيق إسلامي شامل'),
            SizedBox(height: 8),
            Text('الإصدار: 2.0.0'),
            SizedBox(height: 8),
            Text('تطبيق يساعدك على المحافظة على أذكارك اليومية ومواقيت صلاتك.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
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
      child: Column(children: children),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ListTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
