#!/bin/bash

# Pet Finder App - Test Runner Script
# This script generates mocks and runs all tests

echo "🧪 Pet Finder App - Test Suite"
echo "================================"

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Generate mock files
echo "🔧 Generating mock files..."
flutter packages pub run build_runner build --delete-conflicting-outputs

# Check if mock generation was successful
if [ $? -ne 0 ]; then
    echo "❌ Failed to generate mock files"
    exit 1
fi

echo "✅ Mock files generated successfully"

# Run tests
echo "🚀 Running tests..."
flutter test

# Check test results
if [ $? -eq 0 ]; then
    echo "✅ All tests passed!"
else
    echo "❌ Some tests failed"
    exit 1
fi

# Run tests with coverage (optional)
read -p "📊 Run tests with coverage? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📊 Running tests with coverage..."
    flutter test --coverage
    
    if command -v genhtml &> /dev/null; then
        echo "📈 Generating coverage report..."
        genhtml coverage/lcov.info -o coverage/html
        echo "📈 Coverage report generated in coverage/html/"
    else
        echo "ℹ️  Install lcov to generate HTML coverage report"
    fi
fi

echo "🎉 Test suite completed!"
