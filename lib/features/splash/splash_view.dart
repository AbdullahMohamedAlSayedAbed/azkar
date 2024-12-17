import 'package:azkar/constants.dart';
import 'package:azkar/user_storage.dart';
import 'package:azkar/features/Auth/views/sing_up_view.dart';
import 'package:azkar/features/home/views/home_view.dart';
import 'package:azkar/features/onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal.shade100,
        body: Center(
            child: Lottie.asset('images/Animation - 1733854700731.json')));
  }

  Future<Null> navigateToHome() {
    return Future.delayed(
      const Duration(seconds: 4),
      () {
        final bool isVisited = UserStorage.getData(key: isVisitedOnBoarding);
        final bool isSignIn = UserStorage.getData(key: isAuth);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return !isVisited?  const OnboardingView() : isSignIn ? const HomeView() : const SingUpView();
          },
        ));
      },
    );
  }
}
