import 'package:flutter_test/flutter_test.dart';
import 'package:pet_finder_app/features/home/data/models/category_model.dart';
import 'package:pet_finder_app/features/home/data/models/breed_model.dart';

void main() {
  group('Simple Model Tests (No Mocks Required)', () {
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
    });

    group('BreedModel', () {
      test('should create BreedModel from JSON with all fields', () {
        // Arrange
        final json = {
          'weight': {'imperial': '7 - 10', 'metric': '3 - 5'},
          'id': 'abys',
          'name': 'Abyssinian',
          'origin': 'Egypt',
          'life_span': '14 - 15',
          'temperament': 'Active, Energetic, Independent, Intelligent, Gentle',
          'adaptability': 5,
          'affection_level': 5,
          'hypoallergenic': 0,
        };

        // Act
        final breed = BreedModel.fromJson(json);

        // Assert
        expect(breed.id, equals('abys'));
        expect(breed.name, equals('Abyssinian'));
        expect(breed.origin, equals('Egypt'));
        expect(breed.lifeSpan, equals('14 - 15'));
        expect(
          breed.temperament,
          equals('Active, Energetic, Independent, Intelligent, Gentle'),
        );
        expect(breed.adaptability, equals(5));
        expect(breed.affectionLevel, equals(5));
        expect(breed.hypoallergenic, equals(0));
        expect(breed.weight?.imperial, equals('7 - 10'));
        expect(breed.weight?.metric, equals('3 - 5'));
      });

      test('should create BreedModel with minimal required fields', () {
        // Arrange
        final json = {'id': 'test', 'name': 'Test Breed'};

        // Act
        final breed = BreedModel.fromJson(json);

        // Assert
        expect(breed.id, equals('test'));
        expect(breed.name, equals('Test Breed'));
        expect(breed.description, isNull);
        expect(breed.weight, isNull);
      });

      test('should convert BreedModel to JSON', () {
        // Arrange
        final weight = Weight(imperial: '8 - 12', metric: '4 - 6');
        final breed = BreedModel(
          id: 'test',
          name: 'Test Breed',
          description: 'Test description',
          origin: 'Test Country',
          weight: weight,
          adaptability: 4,
          affectionLevel: 5,
        );

        // Act
        final json = breed.toJson();

        // Assert
        expect(json['id'], equals('test'));
        expect(json['name'], equals('Test Breed'));
        expect(json['description'], equals('Test description'));
        expect(json['origin'], equals('Test Country'));
        expect(json['adaptability'], equals(4));
        expect(json['affection_level'], equals(5));
        expect(json['weight']['imperial'], equals('8 - 12'));
        expect(json['weight']['metric'], equals('4 - 6'));
      });
    });

    group('Weight', () {
      test('should create Weight from JSON', () {
        // Arrange
        final json = {'imperial': '7 - 10', 'metric': '3 - 5'};

        // Act
        final weight = Weight.fromJson(json);

        // Assert
        expect(weight.imperial, equals('7 - 10'));
        expect(weight.metric, equals('3 - 5'));
      });

      test('should convert Weight to JSON', () {
        // Arrange
        final weight = Weight(imperial: '8 - 15', metric: '4 - 7');

        // Act
        final json = weight.toJson();

        // Assert
        expect(json['imperial'], equals('8 - 15'));
        expect(json['metric'], equals('4 - 7'));
      });
    });
  });
}
