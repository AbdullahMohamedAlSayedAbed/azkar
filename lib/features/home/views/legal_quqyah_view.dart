import 'package:azkar/features/home/widget/legal_quqyah_view_body.dart';
import 'package:flutter/material.dart';

class LegalQuqyahView extends StatelessWidget {
  const LegalQuqyahView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("الرُّقية الشرعية"),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: const LegalQuqyahViewBody(),
      ),
    );
  }
}
