# Pet Finder App - Test Suite

This directory contains comprehensive unit tests for the Pet Finder App.

## Test Structure

```
test/
├── features/
│   └── home/
│       ├── data/
│       │   ├── models/
│       │   │   ├── category_model_test.dart
│       │   │   └── breed_model_test.dart
│       │   ├── datasources/
│       │   │   ├── category_remote_data_source_test.dart
│       │   │   └── breed_remote_data_source_test.dart
│       │   └── repositories/
│       │       ├── category_repository_test.dart
│       │       └── breed_repository_test.dart
│       └── presentation/
│           ├── cubit/
│           │   ├── home_cubit_test.dart
│           │   └── home_state_test.dart
│           ├── pages/
│           │   └── home_screen_test.dart
│           └── widgets/
│               └── categories_widget_test.dart
├── widget_test.dart
├── test_runner.dart
└── README.md
```

## Test Coverage

### ✅ Data Layer Tests

- **Models**: JSON serialization/deserialization
- **Data Sources**: API communication and error handling
- **Repositories**: Data orchestration and error propagation

### ✅ Presentation Layer Tests

- **Cubit**: State management and business logic
- **States**: State equality and properties
- **Widgets**: UI rendering and user interactions

## Running Tests

### Run All Tests

```bash
flutter test
```

### Run Specific Test Files

```bash
# Run model tests
flutter test test/features/home/data/models/

# Run cubit tests
flutter test test/features/home/presentation/cubit/

# Run widget tests
flutter test test/features/home/presentation/pages/
```

### Run Tests with Coverage

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### Generate Mock Files

```bash
flutter packages pub run build_runner build
```

## Test Categories

### 1. Model Tests

- **CategoryModel**: Tests JSON parsing and serialization
- **BreedModel**: Tests complex nested object parsing
- **Weight**: Tests nested weight object handling

### 2. Data Source Tests

- **CategoryRemoteDataSource**: API calls and response handling
- **BreedRemoteDataSource**: Pagination and query parameters

### 3. Repository Tests

- **CategoryRepository**: Data orchestration and error handling
- **BreedRepository**: Parameter passing and error propagation

### 4. Cubit Tests

- **HomeCubit**: State transitions and business logic
- **HomeState**: State equality and properties

### 5. Widget Tests

- **HomeScreen**: UI rendering and user interactions
- **CategoriesWidget**: Component behavior and callbacks

## Test Dependencies

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4 # Mocking framework
  bloc_test: ^9.1.7 # Bloc testing utilities
  build_runner: ^2.4.9 # Code generation
```

## Mock Files

Mock files are generated using `build_runner` and `mockito`:

- `*_test.mocks.dart` files contain generated mock classes
- Run `flutter packages pub run build_runner build` to generate

## Test Patterns

### 1. Arrange-Act-Assert (AAA)

```dart
test('should return categories when API call succeeds', () async {
  // Arrange
  final categories = [CategoryModel(id: 1, name: 'test')];
  when(mockDataSource.getCategories()).thenAnswer((_) async => categories);

  // Act
  final result = await repository.getCategories();

  // Assert
  expect(result, equals(categories));
  verify(mockDataSource.getCategories()).called(1);
});
```

### 2. Bloc Testing

```dart
blocTest<HomeCubit, HomeState>(
  'should emit [Loading, Loaded] when getCategories succeeds',
  build: () => cubit,
  act: (cubit) => cubit.getCategories(),
  expect: () => [
    isA<CategoriesLoading>(),
    isA<CategoriesLoaded>(),
  ],
);
```

### 3. Widget Testing

```dart
testWidgets('should display categories when loaded', (tester) async {
  // Arrange
  when(mockCubit.state).thenReturn(CategoriesLoaded(categories: categories));

  // Act
  await tester.pumpWidget(createTestWidget());

  // Assert
  expect(find.text('boxes'), findsOneWidget);
});
```

## Best Practices

1. **Test Isolation**: Each test is independent
2. **Mocking**: External dependencies are mocked
3. **Coverage**: Aim for high test coverage
4. **Naming**: Descriptive test names
5. **Structure**: Follow AAA pattern
6. **Assertions**: Specific and meaningful assertions

## Continuous Integration

Tests run automatically on:

- Pull requests
- Main branch pushes
- Release builds

## Troubleshooting

### Common Issues

1. **Mock Generation**: Run `flutter packages pub run build_runner build`
2. **Import Errors**: Check test file imports
3. **State Issues**: Ensure proper state setup in tests
4. **Async Issues**: Use `await` for async operations

### Debug Tips

1. Use `debugPrint()` for debugging
2. Check test output for detailed error messages
3. Verify mock setup and expectations
4. Ensure proper widget tree structure

## Contributing

When adding new features:

1. Write tests first (TDD approach)
2. Ensure all tests pass
3. Maintain test coverage
4. Update this README if needed
