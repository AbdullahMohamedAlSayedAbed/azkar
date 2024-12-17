import 'package:azkar/features/home/widget/wake_up_view_body.dart';
import 'package:flutter/material.dart';

class WakeUpView extends StatelessWidget {
  const WakeUpView({super.key, required this.item, required this.title});
  final List<String> item;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: WakeUpViewBody(item: item),
      ),
    );
  }
}
