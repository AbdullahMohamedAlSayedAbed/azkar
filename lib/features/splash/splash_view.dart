import 'package:azkar/constants.dart';
import 'package:azkar/user_storage.dart';
import 'package:azkar/features/home/views/home_view.dart';
import 'package:azkar/features/onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
    requestNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade100,
      body: Center(
        child: Lottie.asset('assets/images/Animation - 1733854700731.json'),
      ),
    );
  }

  Future<void> navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4));

    if (!mounted) return; 

    final bool isVisited = Preferences.getData(key: isVisitedOnBoarding);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            isVisited ? const HomeView() : const OnboardingView(),
      ),
    );
  }
  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }
}
