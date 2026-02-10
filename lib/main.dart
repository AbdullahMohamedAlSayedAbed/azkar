/// Azkar App Main Entry Point
/// Islamic app with azkar, Quran, prayer times, and more
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:azkar/injection_container.dart';
import 'package:azkar/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize dependencies
  await initDependencies();

  runApp(const AzkarApp());
}
