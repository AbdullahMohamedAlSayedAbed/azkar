/// Allah's Beautiful Names View
/// Shows 99 names of Allah
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkar/features/allah_names/presentation/widgets/allah_name_card.dart';

class AllahNamesView extends StatelessWidget {
  const AllahNamesView({super.key});

  static const List<Map<String, String>> names = [
    {'name': 'الرحمن', 'meaning': 'The Most Gracious'},
    {'name': 'الرحيم', 'meaning': 'The Most Merciful'},
    {'name': 'الملك', 'meaning': 'The King'},
    {'name': 'القدوس', 'meaning': 'The Most Holy'},
    {'name': 'السلام', 'meaning': 'The Source of Peace'},
    {'name': 'المؤمن', 'meaning': 'The Giver of Security'},
    {'name': 'المهيمن', 'meaning': 'The Protector'},
    {'name': 'العزيز', 'meaning': 'The Almighty'},
    {'name': 'الجبار', 'meaning': 'The Compeller'},
    {'name': 'المتكبر', 'meaning': 'The Supreme'},
    {'name': 'الخالق', 'meaning': 'The Creator'},
    {'name': 'البارئ', 'meaning': 'The Evolver'},
    {'name': 'المصور', 'meaning': 'The Fashioner'},
    {'name': 'الغفار', 'meaning': 'The Forgiver'},
    {'name': 'القهار', 'meaning': 'The Subduer'},
    {'name': 'الوهاب', 'meaning': 'The Bestower'},
    {'name': 'الرزاق', 'meaning': 'The Provider'},
    {'name': 'الفتاح', 'meaning': 'The Opener'},
    {'name': 'العليم', 'meaning': 'The All-Knowing'},
    {'name': 'القابض', 'meaning': 'The Withholder'},
    {'name': 'الباسط', 'meaning': 'The Expander'},
    {'name': 'الخافض', 'meaning': 'The Abaser'},
    {'name': 'الرافع', 'meaning': 'The Exalter'},
    {'name': 'المعز', 'meaning': 'The Honourer'},
    {'name': 'المذل', 'meaning': 'The Humiliator'},
    {'name': 'السميع', 'meaning': 'The All-Hearing'},
    {'name': 'البصير', 'meaning': 'The All-Seeing'},
    {'name': 'الحكم', 'meaning': 'The Judge'},
    {'name': 'العدل', 'meaning': 'The Just'},
    {'name': 'اللطيف', 'meaning': 'The Subtle'},
    // ... more names would be added
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('أسماء الله الحسنى'),
        ),
        body: GridView.builder(
          padding: EdgeInsets.all(12.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 0.85,
          ),
          itemCount: names.length,
          itemBuilder: (context, index) {
            final nameData = names[index];

            return AllahNameCard(
              index: index,
              name: nameData['name']!,
              meaning: nameData['meaning']!,
            );
          },
        ),
      ),
    );
  }
}
