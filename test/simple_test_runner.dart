import 'package:flutter_test/flutter_test.dart';

// Import simple test files (no mocks required)
import 'features/home/data/models/simple_model_test.dart' as simple_model_test;
import 'features/home/presentation/cubit/simple_state_test.dart'
    as simple_state_test;
import 'widget_test.dart' as widget_test;

void main() {
  group('Pet Finder App - Simple Tests (No Mocks)', () {
    group('Data Models', () {
      simple_model_test.main();
    });

    group('Presentation States', () {
      simple_state_test.main();
    });

    group('Widget Tests', () {
      widget_test.main();
    });
  });
}
