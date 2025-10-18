import 'package:flutter_test/flutter_test.dart';
import 'package:pet_finder_app/features/home/data/models/category_model.dart';
import 'package:pet_finder_app/features/home/data/models/breed_model.dart';
import 'package:pet_finder_app/features/home/presentation/cubit/home_cubit.dart';

void main() {
  group('Simple State Tests (No Mocks Required)', () {
    group('HomeInitial', () {
      test('should be equal to another HomeInitial', () {
        // Arrange & Act
        final state1 = HomeInitial();
        final state2 = HomeInitial();

        // Assert
        expect(state1, equals(state2));
        expect(state1.props, isEmpty);
      });
    });

    group('CategoriesLoading', () {
      test('should be equal to another CategoriesLoading', () {
        // Arrange & Act
        final state1 = CategoriesLoading();
        final state2 = CategoriesLoading();

        // Assert
        expect(state1, equals(state2));
        expect(state1.props, isEmpty);
      });
    });

    group('CategoriesLoaded', () {
      test('should be equal when categories are the same', () {
        // Arrange
        final categories1 = [
          CategoryModel(id: 5, name: 'boxes'),
          CategoryModel(id: 15, name: 'clothes'),
        ];
        final categories2 = [
          CategoryModel(id: 5, name: 'boxes'),
          CategoryModel(id: 15, name: 'clothes'),
        ];

        // Act
        final state1 = CategoriesLoaded(categories: categories1);
        final state2 = CategoriesLoaded(categories: categories2);

        // Assert
        expect(state1.categories.length, equals(state2.categories.length));
        expect(state1.categories[0].id, equals(state2.categories[0].id));
        expect(state1.categories[0].name, equals(state2.categories[0].name));
        expect(state1.categories[1].id, equals(state2.categories[1].id));
        expect(state1.categories[1].name, equals(state2.categories[1].name));
        expect(state1.props, equals([categories1]));
      });

      test('should not be equal when categories are different', () {
        // Arrange
        final categories1 = [CategoryModel(id: 5, name: 'boxes')];
        final categories2 = [CategoryModel(id: 15, name: 'clothes')];

        // Act
        final state1 = CategoriesLoaded(categories: categories1);
        final state2 = CategoriesLoaded(categories: categories2);

        // Assert
        expect(state1, isNot(equals(state2)));
        expect(state1.props, isNot(equals(state2.props)));
      });

      test('should handle empty categories list', () {
        // Arrange & Act
        final state = CategoriesLoaded(categories: <CategoryModel>[]);

        // Assert
        expect(state.categories, isEmpty);
        expect(state.props, equals([<CategoryModel>[]]));
      });
    });

    group('CategoriesError', () {
      test('should be equal when messages are the same', () {
        // Arrange & Act
        final state1 = CategoriesError(message: 'Network error');
        final state2 = CategoriesError(message: 'Network error');

        // Assert
        expect(state1, equals(state2));
        expect(state1.props, equals(['Network error']));
      });

      test('should not be equal when messages are different', () {
        // Arrange & Act
        final state1 = CategoriesError(message: 'Network error');
        final state2 = CategoriesError(message: 'API error');

        // Assert
        expect(state1, isNot(equals(state2)));
        expect(state1.props, isNot(equals(state2.props)));
      });
    });

    group('BreedsLoading', () {
      test('should be equal to another BreedsLoading', () {
        // Arrange & Act
        final state1 = BreedsLoading();
        final state2 = BreedsLoading();

        // Assert
        expect(state1, equals(state2));
        expect(state1.props, isEmpty);
      });
    });

    group('BreedsLoaded', () {
      test('should be equal when breeds are the same', () {
        // Arrange
        final breeds1 = [
          BreedModel(id: 'abys', name: 'Abyssinian'),
          BreedModel(id: 'aege', name: 'Aegean'),
        ];
        final breeds2 = [
          BreedModel(id: 'abys', name: 'Abyssinian'),
          BreedModel(id: 'aege', name: 'Aegean'),
        ];

        // Act
        final state1 = BreedsLoaded(breeds: breeds1);
        final state2 = BreedsLoaded(breeds: breeds2);

        // Assert
        expect(state1.breeds.length, equals(state2.breeds.length));
        expect(state1.breeds[0].id, equals(state2.breeds[0].id));
        expect(state1.breeds[0].name, equals(state2.breeds[0].name));
        expect(state1.breeds[1].id, equals(state2.breeds[1].id));
        expect(state1.breeds[1].name, equals(state2.breeds[1].name));
        expect(state1.props, equals([breeds1]));
      });

      test('should not be equal when breeds are different', () {
        // Arrange
        final breeds1 = [BreedModel(id: 'abys', name: 'Abyssinian')];
        final breeds2 = [BreedModel(id: 'aege', name: 'Aegean')];

        // Act
        final state1 = BreedsLoaded(breeds: breeds1);
        final state2 = BreedsLoaded(breeds: breeds2);

        // Assert
        expect(state1, isNot(equals(state2)));
        expect(state1.props, isNot(equals(state2.props)));
      });

      test('should handle empty breeds list', () {
        // Arrange & Act
        final state = BreedsLoaded(breeds: <BreedModel>[]);

        // Assert
        expect(state.breeds, isEmpty);
        expect(state.props, equals([<BreedModel>[]]));
      });
    });

    group('BreedsError', () {
      test('should be equal when messages are the same', () {
        // Arrange & Act
        final state1 = BreedsError(message: 'Network error');
        final state2 = BreedsError(message: 'Network error');

        // Assert
        expect(state1, equals(state2));
        expect(state1.props, equals(['Network error']));
      });

      test('should not be equal when messages are different', () {
        // Arrange & Act
        final state1 = BreedsError(message: 'Network error');
        final state2 = BreedsError(message: 'API error');

        // Assert
        expect(state1, isNot(equals(state2)));
        expect(state1.props, isNot(equals(state2.props)));
      });
    });

    group('State inheritance', () {
      test('all states should extend HomeState', () {
        // Arrange & Act
        final homeInitial = HomeInitial();
        final categoriesLoading = CategoriesLoading();
        final categoriesLoaded = CategoriesLoaded(categories: []);
        final categoriesError = CategoriesError(message: 'error');
        final breedsLoading = BreedsLoading();
        final breedsLoaded = BreedsLoaded(breeds: []);
        final breedsError = BreedsError(message: 'error');

        // Assert
        expect(homeInitial, isA<HomeState>());
        expect(categoriesLoading, isA<HomeState>());
        expect(categoriesLoaded, isA<HomeState>());
        expect(categoriesError, isA<HomeState>());
        expect(breedsLoading, isA<HomeState>());
        expect(breedsLoaded, isA<HomeState>());
        expect(breedsError, isA<HomeState>());
      });
    });
  });
}
