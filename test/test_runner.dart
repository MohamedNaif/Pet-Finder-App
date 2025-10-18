import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'features/home/data/datasources/breed_remote_data_source_test.dart' as categories_widget_test;
import 'features/home/data/models/category_model_test.dart'
    as category_model_test;
import 'features/home/data/models/breed_model_test.dart' as breed_model_test;
import 'features/home/data/datasources/category_remote_data_source_test.dart'
    as category_datasource_test;
import 'features/home/data/datasources/breed_remote_data_source_test.dart'
    as breed_datasource_test;
import 'features/home/data/repositories/category_repository_test.dart'
    as category_repository_test;
import 'features/home/data/repositories/breed_repository_test.dart'
    as breed_repository_test;
import 'features/home/presentation/cubit/home_cubit_test.dart'
    as home_cubit_test;
import 'features/home/presentation/cubit/home_state_test.dart'
    as home_state_test;
import 'features/home/presentation/pages/home_screen_test.dart'
    as home_screen_test;
// import 'features/home/presentation/widgets/categories_widget_test.dart'
//     as categories_widget_test;
import 'widget_test.dart' as widget_test;

void main() {
  group('Pet Finder App Tests', () {
    group('Data Models', () {
      category_model_test.main();
      breed_model_test.main();
    });

    group('Data Sources', () {
      category_datasource_test.main();
      breed_datasource_test.main();
    });

    group('Repositories', () {
      category_repository_test.main();
      breed_repository_test.main();
    });

    group('Presentation Layer', () {
      home_cubit_test.main();
      home_state_test.main();
    });

    group('Widget Tests', () {
      home_screen_test.main();
      categories_widget_test.main();
      widget_test.main();
    });
  });
}
