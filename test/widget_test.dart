// Basic Flutter widget test for Azkar app
import 'package:flutter_test/flutter_test.dart';
import 'package:azkar/app.dart';

void main() {
  testWidgets('AzkarApp widget test', (WidgetTester tester) async {
    // Pump the app widget
    await tester.pumpWidget(const AzkarApp());
  });
}
