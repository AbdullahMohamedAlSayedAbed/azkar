
import 'package:azkar/features/home/functions/show_exit_dialog.dart';
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
          leading: IconButton(
              onPressed: () {
                showExitDialog(context);
              },
              icon: const Icon(Icons.exit_to_app)),
          centerTitle: true,
        ),
        body: const HomeViewBody(),
      ),
    );
  }
}
