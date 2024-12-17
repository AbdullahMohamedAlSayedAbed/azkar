import 'package:azkar/features/home/widget/dua_card.dart';
import 'package:flutter/material.dart';

class DetailsViewBody extends StatelessWidget {
  const DetailsViewBody({super.key, required this.azkarList});
  final List<Map<String, dynamic>> azkarList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 16),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: azkarList.length,
        itemBuilder: (context, index) {
          final zekr = azkarList[index];
          return DuaCard(
            text: zekr['zekr'],
            note: zekr['bless'],
            initialRepeat: zekr['repeat'],
          );
        },
      ),
    );
  }
}
