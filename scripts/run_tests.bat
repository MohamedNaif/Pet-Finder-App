@echo off
REM Pet Finder App - Test Runner Script (Windows)
REM This script generates mocks and runs all tests

echo 🧪 Pet Finder App - Test Suite
echo ================================

REM Check if Flutter is installed
where flutter >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo ❌ Flutter is not installed or not in PATH
    exit /b 1
)

REM Get dependencies
echo 📦 Getting dependencies...
flutter pub get

REM Generate mock files
echo 🔧 Generating mock files...
flutter packages pub run build_runner build --delete-conflicting-outputs

REM Check if mock generation was successful
if %ERRORLEVEL% neq 0 (
    echo ❌ Failed to generate mock files
    exit /b 1
)

echo ✅ Mock files generated successfully

REM Run tests
echo 🚀 Running tests...
flutter test

REM Check test results
if %ERRORLEVEL% equ 0 (
    echo ✅ All tests passed!
) else (
    echo ❌ Some tests failed
    exit /b 1
)

REM Ask about coverage
set /p coverage="📊 Run tests with coverage? (y/n): "
if /i "%coverage%"=="y" (
    echo 📊 Running tests with coverage...
    flutter test --coverage
    
    where genhtml >nul 2>nul
    if %ERRORLEVEL% equ 0 (
        echo 📈 Generating coverage report...
        genhtml coverage/lcov.info -o coverage/html
        echo 📈 Coverage report generated in coverage/html/
    ) else (
        echo ℹ️  Install lcov to generate HTML coverage report
    )
)

echo 🎉 Test suite completed!
pause
