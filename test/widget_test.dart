import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Simple widget test', (WidgetTester tester) async {
    // Build a simple test widget
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Text('Test'))),
    );

    // Verify that the text widget is found
    expect(find.text('Test'), findsOneWidget);
  });
}
