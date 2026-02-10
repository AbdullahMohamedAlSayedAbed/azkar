/// Duas Categories View
/// Shows categories of duas
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkar/core/routes/app_router.dart';
import 'package:azkar/features/duas/presentation/widgets/dua_category_card.dart';

class DuasCategoriesView extends StatelessWidget {
  const DuasCategoriesView({super.key});

  static const List<Map<String, dynamic>> categories = [
    {
      'id': 'rizq',
      'icon': Icons.attach_money,
      'title': 'دعاء الرزق',
      'color': Color(0xFF43A047)
    },
    {
      'id': 'shifa',
      'icon': Icons.healing,
      'title': 'دعاء الشفاء',
      'color': Color(0xFFE53935)
    },
    {
      'id': 'travel',
      'icon': Icons.flight,
      'title': 'دعاء السفر',
      'color': Color(0xFF1E88E5)
    },
    {
      'id': 'anxiety',
      'icon': Icons.sentiment_satisfied_alt,
      'title': 'دعاء الهم',
      'color': Color(0xFF7B1FA2)
    },
    {
      'id': 'food',
      'icon': Icons.restaurant,
      'title': 'دعاء الطعام',
      'color': Color(0xFFFF9800)
    },
    {
      'id': 'sleep',
      'icon': Icons.bedtime,
      'title': 'دعاء النوم',
      'color': Color(0xFF5C6BC0)
    },
    {
      'id': 'mosque',
      'icon': Icons.mosque,
      'title': 'دعاء المسجد',
      'color': Color(0xFF00897B)
    },
    {
      'id': 'eid',
      'icon': Icons.celebration,
      'title': 'دعاء الأعياد',
      'color': Color(0xFFE91E63)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الأدعية'),
        ),
        body: GridView.builder(
          padding: EdgeInsets.all(16.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.1,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];

            return DuaCategoryCard(
              icon: category['icon'] as IconData,
              title: category['title'] as String,
              color: category['color'] as Color,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.duasList,
                  arguments: DuasListArgs(
                    category: category['id'] as String,
                    title: category['title'] as String,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
