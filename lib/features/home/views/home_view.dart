
import 'package:azkar/features/home/widget/home_view_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('اذكار'),
          centerTitle: true,
        ),
        body: const HomeViewBody(),
      ),
    );
  }
}
