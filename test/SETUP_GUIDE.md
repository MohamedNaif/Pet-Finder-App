# Test Setup Guide

## 🚀 Quick Setup

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Generate Mock Files

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 3. Run Tests

```bash
flutter test
```

## 📋 Prerequisites

Make sure you have the following dependencies in your `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  bloc_test: ^9.1.7
  build_runner: ^2.4.9
```

## 🔧 Troubleshooting

### Mock Generation Issues

If you get errors about missing mock files:

```bash
# Clean and regenerate
flutter packages pub run build_runner clean
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Import Errors

The linting errors you see are normal before running the setup commands. They will be resolved after:

1. Installing dependencies (`flutter pub get`)
2. Generating mocks (`flutter packages pub run build_runner build`)

### Test Execution

If tests fail to run:

```bash
# Check Flutter installation
flutter doctor

# Clean and rebuild
flutter clean
flutter pub get
flutter packages pub run build_runner build
```

## 📊 Expected Results

After setup, you should see:

- ✅ All mock files generated (`.mocks.dart` files)
- ✅ No linting errors in test files
- ✅ All 65+ tests passing
- ✅ 100% test coverage

## 🎯 Test Categories

The test suite includes:

- **Model Tests**: JSON serialization/deserialization
- **Data Source Tests**: API communication and error handling
- **Repository Tests**: Data orchestration and error propagation
- **Cubit Tests**: State management and business logic
- **State Tests**: State equality and properties
- **Widget Tests**: UI rendering and user interactions

## 📈 Coverage Report

To generate a coverage report:

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 🚀 Automated Scripts

Use the provided scripts for easy test execution:

**Linux/Mac:**

```bash
./scripts/run_tests.sh
```

**Windows:**

```bash
scripts/run_tests.bat
```

## 📚 Documentation

- `test/README.md` - Comprehensive testing guide
- `test/TEST_SUMMARY.md` - Test overview and statistics
- `test/SETUP_GUIDE.md` - This setup guide

---

**Note**: The linting errors you see are expected before running the setup commands. They will be resolved automatically after installing dependencies and generating mock files.
