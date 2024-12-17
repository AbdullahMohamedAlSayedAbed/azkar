import 'package:azkar/features/home/dummy/moring_zekar.dart';
import 'package:azkar/features/home/widget/legal_quqyah_widget.dart';
import 'package:flutter/material.dart';

class LegalQuqyahViewBody extends StatelessWidget {
  const LegalQuqyahViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 16),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: legalQuqyahList.length,
        itemBuilder: (context, index) {
          return LegalQuqyahWidget(
            category: legalQuqyahList[index]['category'],
            reference: legalQuqyahList[index]['reference'],
            zekr: legalQuqyahList[index]['zekr'],
          );
        },
      ),
    );
  }
}
