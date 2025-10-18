# Categories Feature - Usage Guide

## Overview

This feature implements a simplified clean architecture pattern for fetching categories from the API **without entities and use cases**. The architecture follows this structure:

```
features/home/
├── data/
│   ├── models/
│   │   └── category_model.dart          # Data model
│   ├── datasources/
│   │   └── category_remote_data_source.dart  # API calls
│   └── repositories/
│       └── category_repository.dart     # Data layer
└── presentation/
    ├── cubit/
    │   ├── home_cubit.dart              # Business logic
    │   └── home_state.dart              # State management
    ├── pages/
    │   └── categories_example_screen.dart  # Example screen
    └── widgets/
        └── categories_widget.dart       # Reusable widget
```

## API Configuration

### Endpoint

The categories endpoint is configured in `lib/core/api/end_points.dart`:

```dart
static const String categoriesV1 = '/api/v1/categories';
```

Full URL: `{{endpoint}}v1/categories`

### Response Format

```json
[
  {
    "id": 5,
    "name": "boxes"
  },
  {
    "id": 15,
    "name": "clothes"
  }
]
```

## Architecture Layers

### 1. Model Layer (`CategoryModel`)

Located: `lib/features/home/data/models/category_model.dart`

```dart
class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
```

### 2. Data Source Layer

Located: `lib/features/home/data/datasources/category_remote_data_source.dart`

Handles all API communication:

```dart
abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiConsumer apiConsumer;
  // ... implementation
}
```

### 3. Repository Layer

Located: `lib/features/home/data/repositories/category_repository.dart`

Manages data flow and error handling:

```dart
abstract class CategoryRepository {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  // ... implementation
}
```

### 4. Presentation Layer (Cubit)

Located: `lib/features/home/presentation/cubit/home_cubit.dart`

Manages business logic and state:

```dart
class HomeCubit extends Cubit<HomeState> {
  final CategoryRepository categoryRepository;

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    try {
      final categories = await categoryRepository.getCategories();
      emit(CategoriesLoaded(categories: categories));
    } catch (e) {
      emit(CategoriesError(message: e.toString()));
    }
  }
}
```

### 5. States

Located: `lib/features/home/presentation/cubit/home_state.dart`

Three states for managing UI:

- `CategoriesLoading` - Show loading indicator
- `CategoriesLoaded` - Display categories
- `CategoriesError` - Show error message

## Usage Examples

### Option 1: Using the Pre-built Widget

The easiest way to use categories in your screen:

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_finder_app/core/di/dependency_injection.dart';
import 'package:pet_finder_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:pet_finder_app/features/home/presentation/widgets/categories_widget.dart';

class YourScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getCategories(),
      child: Scaffold(
        body: Column(
          children: [
            // Your existing widgets...

            CategoriesWidget(
              onCategorySelected: (category) {
                print('Selected: ${category.name}');
                // Handle category selection
              },
            ),

            // Your existing widgets...
          ],
        ),
      ),
    );
  }
}
```

### Option 2: Full Example Screen

Use the complete example screen:

```dart
import 'package:pet_finder_app/features/home/presentation/pages/categories_example_screen.dart';

// Navigate to it
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => CategoriesExampleScreen(),
  ),
);
```

### Option 3: Custom Implementation

Build your own custom UI with BlocBuilder:

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_finder_app/core/di/dependency_injection.dart';
import 'package:pet_finder_app/features/home/presentation/cubit/home_cubit.dart';

class CustomCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getCategories(),
      child: Scaffold(
        appBar: AppBar(title: Text('Categories')),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is CategoriesLoading) {
              return Center(child: CircularProgressIndicator());
            }
            else if (state is CategoriesLoaded) {
              return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return ListTile(
                    title: Text(category.name),
                    subtitle: Text('ID: ${category.id}'),
                  );
                },
              );
            }
            else if (state is CategoriesError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
```

## Integration with Existing HomeScreen

To integrate categories into your existing `home_screen.dart`:

1. Wrap your HomeScreen with BlocProvider:

```dart
BlocProvider(
  create: (context) => getIt<HomeCubit>()..getCategories(),
  child: HomeScreen(),
)
```

2. Replace the hardcoded category chips with CategoriesWidget:

```dart
// Replace lines 56-73 in home_screen.dart with:
CategoriesWidget(
  selectedCategoryName: selectedCategory,
  onCategorySelected: (category) {
    setState(() {
      selectedCategory = category.name;
    });
    // Filter pets based on selected category
  },
),
```

## Dependency Injection

All dependencies are registered in `lib/core/di/dependency_injection.dart`:

```dart
void setupDependencyInjection() {
  // API Consumer
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: getIt<Dio>()),
  );

  // Category Data Source
  getIt.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );

  // Category Repository
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(remoteDataSource: getIt<CategoryRemoteDataSource>()),
  );

  // Home Cubit
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(categoryRepository: getIt<CategoryRepository>()),
  );
}
```

## Error Handling

The feature includes built-in error handling:

- **Network errors**: Caught in the repository and emitted as `CategoriesError`
- **Parsing errors**: Handled in the data source
- **UI errors**: Displayed with retry button in the error widget

## Testing

To test the categories feature:

```dart
// Example test
void main() {
  group('CategoryRepository', () {
    test('should return list of categories', () async {
      // Arrange
      final mockDataSource = MockCategoryRemoteDataSource();
      final repository = CategoryRepositoryImpl(remoteDataSource: mockDataSource);

      // Act
      final result = await repository.getCategories();

      // Assert
      expect(result, isA<List<CategoryModel>>());
    });
  });
}
```

## Benefits of This Approach

✅ **Simplified Architecture**: No entity and use case layers for simpler implementation  
✅ **Separation of Concerns**: Clear separation between data, domain, and presentation  
✅ **Testability**: Easy to mock and test each layer independently  
✅ **Reusability**: CategoriesWidget can be reused across multiple screens  
✅ **State Management**: Robust state handling with Cubit/Bloc  
✅ **Dependency Injection**: Clean dependency management with GetIt

## Notes

- The `{{endpoint}}` placeholder should be replaced with your actual base URL in `end_points.dart`
- Make sure `setupDependencyInjection()` is called in `main.dart` before running the app
- The current implementation uses the endpoint `/api/v1/categories`
- Categories are fetched automatically when the cubit is created
- You can manually refresh categories by calling `context.read<HomeCubit>().getCategories()`
