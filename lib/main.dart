import 'package:azkar/user_storage.dart';
import 'package:azkar/features/splash/splash_view.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserStorage.init();
  runApp(const Azkar());
}

class Azkar extends StatelessWidget {
  const Azkar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
