import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:pet_finder_app/features/home/data/models/category_model.dart';
import 'package:pet_finder_app/features/home/data/models/breed_model.dart';
import 'package:pet_finder_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:pet_finder_app/features/home/presentation/pages/home_screen.dart';

import 'home_screen_test.mocks.dart';

@GenerateMocks([HomeCubit])
void main() {
  group('HomeScreen', () {
    late MockHomeCubit mockHomeCubit;

    setUp(() {
      mockHomeCubit = MockHomeCubit();
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: BlocProvider<HomeCubit>(
          create: (context) => mockHomeCubit,
          child: const HomeScreen(),
        ),
      );
    }

    testWidgets('should display app title', (WidgetTester tester) async {
      // Arrange
      when(mockHomeCubit.state).thenReturn(HomeInitial());
      when(mockHomeCubit.stream).thenAnswer((_) => Stream.value(HomeInitial()));

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Find Your Forever Pet'), findsOneWidget);
    });

    testWidgets('should display search bar', (WidgetTester tester) async {
      // Arrange
      when(mockHomeCubit.state).thenReturn(HomeInitial());
      when(mockHomeCubit.stream).thenAnswer((_) => Stream.value(HomeInitial()));

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Search'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.tune), findsOneWidget);
    });

    testWidgets('should display categories section title', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockHomeCubit.state).thenReturn(HomeInitial());
      when(mockHomeCubit.stream).thenAnswer((_) => Stream.value(HomeInitial()));

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Categories'), findsOneWidget);
    });

    testWidgets('should display breeds section title', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockHomeCubit.state).thenReturn(HomeInitial());
      when(mockHomeCubit.stream).thenAnswer((_) => Stream.value(HomeInitial()));

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Popular Breeds'), findsOneWidget);
    });

    testWidgets('should display loading shimmer for categories', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockHomeCubit.state).thenReturn(CategoriesLoading());
      when(
        mockHomeCubit.stream,
      ).thenAnswer((_) => Stream.value(CategoriesLoading()));

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should display categories when loaded', (
      WidgetTester tester,
    ) async {
      // Arrange
      final categories = [
        CategoryModel(id: 5, name: 'boxes'),
        CategoryModel(id: 15, name: 'clothes'),
        CategoryModel(id: 1, name: 'hats'),
      ];
      when(
        mockHomeCubit.state,
      ).thenReturn(CategoriesLoaded(categories: categories));
      when(mockHomeCubit.stream).thenAnswer(
        (_) => Stream.value(CategoriesLoaded(categories: categories)),
      );

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('All'), findsOneWidget);
      expect(find.text('boxes'), findsOneWidget);
      expect(find.text('clothes'), findsOneWidget);
      expect(find.text('hats'), findsOneWidget);
    });

    testWidgets('should display error message for categories', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(
        mockHomeCubit.state,
      ).thenReturn(CategoriesError(message: 'Network error'));
      when(mockHomeCubit.stream).thenAnswer(
        (_) => Stream.value(CategoriesError(message: 'Network error')),
      );

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Failed to load categories'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('should display loading shimmer for breeds', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockHomeCubit.state).thenReturn(BreedsLoading());
      when(
        mockHomeCubit.stream,
      ).thenAnswer((_) => Stream.value(BreedsLoading()));

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should display breeds when loaded', (
      WidgetTester tester,
    ) async {
      // Arrange
      final breeds = [
        BreedModel(id: 'abys', name: 'Abyssinian'),
        BreedModel(id: 'aege', name: 'Aegean'),
      ];
      when(mockHomeCubit.state).thenReturn(BreedsLoaded(breeds: breeds));
      when(
        mockHomeCubit.stream,
      ).thenAnswer((_) => Stream.value(BreedsLoaded(breeds: breeds)));

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Abyssinian'), findsOneWidget);
      expect(find.text('Aegean'), findsOneWidget);
      expect(find.byIcon(Icons.pets), findsWidgets);
    });

    testWidgets('should display error message for breeds', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(
        mockHomeCubit.state,
      ).thenReturn(BreedsError(message: 'Network error'));
      when(
        mockHomeCubit.stream,
      ).thenAnswer((_) => Stream.value(BreedsError(message: 'Network error')));

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Failed to load breeds'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('should call getCategories when retry button is tapped', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(
        mockHomeCubit.state,
      ).thenReturn(CategoriesError(message: 'Network error'));
      when(mockHomeCubit.stream).thenAnswer(
        (_) => Stream.value(CategoriesError(message: 'Network error')),
      );

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.tap(find.text('Retry'));

      // Assert
      verify(mockHomeCubit.getCategories()).called(1);
    });

    testWidgets('should call getBreeds when retry button is tapped', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(
        mockHomeCubit.state,
      ).thenReturn(BreedsError(message: 'Network error'));
      when(
        mockHomeCubit.stream,
      ).thenAnswer((_) => Stream.value(BreedsError(message: 'Network error')));

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.tap(find.text('Retry'));

      // Assert
      verify(mockHomeCubit.getBreeds(limit: 10, page: 0)).called(1);
    });

    testWidgets('should display pet cards', (WidgetTester tester) async {
      // Arrange
      when(mockHomeCubit.state).thenReturn(HomeInitial());
      when(mockHomeCubit.stream).thenAnswer((_) => Stream.value(HomeInitial()));

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.text('Joli'), findsOneWidget);
      expect(find.text('Oliver'), findsOneWidget);
      expect(find.text('Tom'), findsOneWidget);
    });

    testWidgets('should display bottom navigation bar', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockHomeCubit.state).thenReturn(HomeInitial());
      when(mockHomeCubit.stream).thenAnswer((_) => Stream.value(HomeInitial()));

      // Act
      await tester.pumpWidget(createTestWidget());

      // Assert
      expect(find.byIcon(Icons.home_outlined), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });
  });
}
