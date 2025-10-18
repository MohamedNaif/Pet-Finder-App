# 🐾 Pet Finder App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.8.1-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.8.1-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Tests](https://img.shields.io/badge/Tests-70%2B%20Passing-success?style=for-the-badge)

**A modern, feature-rich Flutter application for discovering and exploring cat breeds using The Cat API**

[Features](#-features) • [Architecture](#-architecture) • [Getting Started](#-getting-started) • [Testing](#-testing) • [Documentation](#-documentation)

</div>

---

## 📱 About

Pet Finder App is a comprehensive Flutter application that allows users to browse cat breeds, explore categories, and discover detailed information about different cat breeds. Built with clean architecture principles and modern Flutter best practices, the app provides a seamless user experience with support for multiple languages and responsive design.

## ✨ Features

### Core Features

- 🐱 **Browse Cat Breeds** - Explore a comprehensive list of cat breeds with detailed information
- 📂 **Category Exploration** - Discover cats by different categories
- 🔍 **Advanced Search** - Search and filter cats with intuitive UI
- 🌐 **Multi-language Support** - Arabic and English localization
- 🎨 **Modern UI/UX** - Beautiful, responsive design with smooth animations
- 📱 **Cross-platform** - Runs on Android, iOS, Web, Windows, Linux, and macOS

### Technical Features

- ⚡ **State Management** - BLoC pattern with flutter_bloc
- 🏗️ **Clean Architecture** - Simplified architecture (without entity/use case layers)
- 🔄 **API Integration** - RESTful API integration with The Cat API
- 💾 **Local Storage** - Efficient caching with SharedPreferences
- 🎯 **Dependency Injection** - Service locator pattern with get_it
- 🧪 **Comprehensive Testing** - 70+ unit and widget tests
- 🌍 **Internationalization** - Easy localization with easy_localization

## 🏗️ Architecture

The application follows a **Simplified Clean Architecture** pattern with three main layers:

```
lib/
├── config/               # App configuration
│   ├── lang_manager.dart     # Localization settings
│   ├── routing/              # App navigation
│   └── theme/                # App theming
├── core/                 # Core utilities
│   ├── api/                  # API consumer & endpoints
│   ├── di/                   # Dependency injection
│   ├── storage/              # Local storage
│   └── widgets/              # Reusable widgets
└── features/             # Feature modules
    ├── home/                 # Home feature
    │   ├── data/
    │   │   ├── datasources/  # Remote data sources
    │   │   ├── models/       # Data models
    │   │   └── repositories/ # Repository implementations
    │   └── presentation/
    │       ├── cubit/        # State management
    │       ├── pages/        # UI screens
    │       └── widgets/      # Feature widgets
    └── splash/               # Splash screen
```

### Design Patterns

- **BLoC Pattern** - For state management
- **Repository Pattern** - For data abstraction
- **Dependency Injection** - For loose coupling
- **Factory Pattern** - For object creation

## 🚀 Getting Started

### Prerequisites

- Flutter SDK: `>=3.8.1`
- Dart SDK: `>=3.8.1`
- Android Studio / VS Code
- Xcode (for iOS development)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/pet_finder_app.git
   cd pet_finder_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate mock files (for testing)**

   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Android

```bash
flutter run -d android
```

#### iOS

```bash
flutter run -d ios
```

#### Web

```bash
flutter run -d chrome
```

#### Desktop

```bash
# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

## 🧪 Testing

The project includes comprehensive test coverage with 70+ tests across different layers.

### Run All Tests

```bash
flutter test
```

### Run Specific Test Suites

**Data Layer Tests**

```bash
flutter test test/features/home/data/
```

**Presentation Layer Tests**

```bash
flutter test test/features/home/presentation/cubit/
```

**Simple Tests (No Setup Required)**

```bash
flutter test test/simple_test_runner.dart
```

### Test Coverage

```bash
flutter test --coverage
```

### Test Structure

- ✅ **Models** - JSON serialization/deserialization
- ✅ **Data Sources** - API integration with mocks
- ✅ **Repositories** - Business logic layer
- ✅ **Cubits** - State management
- ✅ **Widgets** - UI components

For detailed testing documentation, see [`test/README.md`](test/README.md)

## 📦 Dependencies

### Core Dependencies

- **flutter_bloc** `^9.1.1` - State management
- **dio** `^5.9.0` - HTTP client
- **get_it** `^8.2.0` - Dependency injection
- **go_router** `^16.2.4` - Navigation
- **easy_localization** `^3.0.8` - Internationalization

### UI Dependencies

- **cached_network_image** `^3.4.1` - Image caching
- **shimmer** `^3.0.0` - Loading animations
- **carousel_slider** `^5.1.1` - Image carousels
- **flutter_svg** `^2.2.1` - SVG support
- **cherry_toast** `^1.13.0` - Toast notifications

### Testing Dependencies

- **mockito** `^5.4.4` - Mocking framework
- **bloc_test** `^10.0.0` - BLoC testing utilities
- **build_runner** `^2.4.9` - Code generation

## 🌍 Internationalization

The app supports multiple languages:

- 🇺🇸 English (en-US)
- 🇸🇦 Arabic (ar-SA)

Language files are located in `assets/translations/`

### Adding a New Language

1. Create a new JSON file in `assets/translations/`
2. Add the locale to `config/lang_manager.dart`
3. Update `main.dart` with the new supported locale

## 🎨 Theming

The app features a modern, customizable theme system:

- Light/Dark mode support
- Custom color schemes
- Typography system
- Responsive design

Theme configuration: `lib/config/theme/app_theme.dart`

## 📡 API Integration

The app integrates with [The Cat API](https://thecatapi.com/) to fetch cat breeds and categories.

### Endpoints Used

- `GET /v1/categories` - Fetch cat categories
- `GET /v1/breeds` - Fetch cat breeds with pagination

API configuration: `lib/core/api/end_points.dart`

## 🔧 Configuration

### Environment Setup

1. **Shared Preferences** - Initialized on app startup
2. **Dependency Injection** - Configured in `lib/core/di/dependency_injection.dart`
3. **BLoC Observer** - Custom observer for debugging state changes

### API Configuration

Update the base URL in `lib/core/api/end_points.dart`:

```dart
static const String baseUrl = 'https://api.thecatapi.com';
```

## 📝 Code Style

The project follows the official [Flutter Style Guide](https://flutter.dev/docs/development/tools/formatting) and uses `flutter_lints` for code analysis.

### Linting

```bash
flutter analyze
```

### Formatting

```bash
flutter format .
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Contribution Guidelines

- Follow the existing code style
- Write tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


## 🙏 Acknowledgments

- [The Cat API](https://thecatapi.com/) - For providing the cat data
- [Flutter Team](https://flutter.dev/) - For the amazing framework
- All contributors and supporters

## 📚 Documentation

### Additional Resources

- [Test Documentation](test/README.md) - Comprehensive testing guide
- [Error Solutions](test/ERROR_SOLUTION_GUIDE.md) - Common issues and fixes
- [Setup Guide](test/SETUP_GUIDE.md) - Detailed setup instructions
- [Test Summary](test/FINAL_SUMMARY.md) - Test suite overview

### Project Documentation

- [Architecture Overview](docs/ARCHITECTURE.md) - Coming soon
- [API Documentation](docs/API.md) - Coming soon
- [Contributing Guide](CONTRIBUTING.md) - Coming soon

## 🐛 Known Issues

No known issues at this time. Please report any bugs in the [Issues](https://github.com/yourusername/pet_finder_app/issues) section.

## 🔮 Future Enhancements

- [ ] Offline mode with local database
- [ ] Favorite breeds feature
- [ ] Social sharing capabilities
- [ ] User authentication
- [ ] Breed comparison feature
- [ ] Advanced filtering options
- [ ] Push notifications
- [ ] Dark mode toggle

## 📊 Project Stats

- **Total Lines of Code**: ~10,000+
- **Test Coverage**: 70+ tests
- **Supported Platforms**: 6 (Android, iOS, Web, Windows, macOS, Linux)
- **Languages**: 2 (English, Arabic)
- **Features**: 3 main modules

---

<div align="center">

**Made with ❤️ using Flutter**

⭐ Star this repo if you find it helpful!

[Report Bug](https://github.com/yourusername/pet_finder_app/issues) • [Request Feature](https://github.com/yourusername/pet_finder_app/issues)

</div>
