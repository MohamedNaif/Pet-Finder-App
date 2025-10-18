import 'package:flutter_test/flutter_test.dart';
import 'package:pet_finder_app/features/home/data/models/category_model.dart';

void main() {
  group('CategoryModel', () {
    test('should create CategoryModel from JSON', () {
      // Arrange
      final json = {'id': 5, 'name': 'boxes'};

      // Act
      final category = CategoryModel.fromJson(json);

      // Assert
      expect(category.id, equals(5));
      expect(category.name, equals('boxes'));
    });

    test('should convert CategoryModel to JSON', () {
      // Arrange
      final category = CategoryModel(id: 15, name: 'clothes');

      // Act
      final json = category.toJson();

      // Assert
      expect(json['id'], equals(15));
      expect(json['name'], equals('clothes'));
    });

    test('should handle different category data', () {
      // Arrange
      final json = {'id': 1, 'name': 'hats'};

      // Act
      final category = CategoryModel.fromJson(json);

      // Assert
      expect(category.id, equals(1));
      expect(category.name, equals('hats'));
    });

    test('should create CategoryModel with required parameters', () {
      // Act
      final category = CategoryModel(id: 7, name: 'ties');

      // Assert
      expect(category.id, equals(7));
      expect(category.name, equals('ties'));
    });
  });
}
