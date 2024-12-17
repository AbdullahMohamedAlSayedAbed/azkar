import 'package:azkar/features/home/widget/counter_view_body.dart';
import 'package:flutter/material.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('مسبحة الكترونية'),
          centerTitle: true,
        ),
        body: const CounterViewBody(),
      ),
    );
  }
}
