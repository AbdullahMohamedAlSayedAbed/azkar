import 'package:azkar/features/home/widget/dua_card.dart';
import 'package:flutter/material.dart';

class WakeUpViewBody extends StatelessWidget {
  const WakeUpViewBody({super.key, required this.item});
  final List<String> item;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: item.length,
      itemBuilder: (context, index) {
        return DuaCard(
          text: item[index],
        );
      },
    );
  }
}
