import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:pet_finder_app/core/api/api_consumer.dart';
import 'package:pet_finder_app/features/home/data/datasources/breed_remote_data_source.dart';
import 'package:pet_finder_app/features/home/data/models/breed_model.dart';

import 'breed_remote_data_source_test.mocks.dart';

@GenerateMocks([ApiConsumer])
void main() {
  late BreedRemoteDataSourceImpl dataSource;
  late MockApiConsumer mockApiConsumer;

  setUp(() {
    mockApiConsumer = MockApiConsumer();
    dataSource = BreedRemoteDataSourceImpl(apiConsumer: mockApiConsumer);
  });

  group('BreedRemoteDataSource', () {
    test('should return list of breeds when API call is successful', () async {
      // Arrange
      final breedsJson = [
        {
          'weight': {'imperial': '7 - 10', 'metric': '3 - 5'},
          'id': 'abys',
          'name': 'Abyssinian',
          'origin': 'Egypt',
          'life_span': '14 - 15',
          'temperament': 'Active, Energetic, Independent',
          'adaptability': 5,
          'affection_level': 5,
        },
        {
          'weight': {'imperial': '7 - 10', 'metric': '3 - 5'},
          'id': 'aege',
          'name': 'Aegean',
          'origin': 'Greece',
          'life_span': '9 - 12',
          'temperament': 'Affectionate, Social, Intelligent',
          'adaptability': 5,
          'affection_level': 4,
        },
      ];

      when(
        mockApiConsumer.get(
          path: anyNamed('path'),
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer((_) async => breedsJson);

      // Act
      final result = await dataSource.getBreeds(limit: 10, page: 0);

      // Assert
      expect(result, isA<List<BreedModel>>());
      expect(result.length, equals(2));
      expect(result[0].id, equals('abys'));
      expect(result[0].name, equals('Abyssinian'));
      expect(result[0].origin, equals('Egypt'));
      expect(result[1].id, equals('aege'));
      expect(result[1].name, equals('Aegean'));
      expect(result[1].origin, equals('Greece'));

      verify(
        mockApiConsumer.get(
          path: anyNamed('path'),
          queryParameters: {'limit': 10, 'page': 0},
        ),
      ).called(1);
    });

    test('should use default parameters when not provided', () async {
      // Arrange
      when(
        mockApiConsumer.get(
          path: anyNamed('path'),
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer((_) async => <Map<String, dynamic>>[]);

      // Act
      await dataSource.getBreeds();

      // Assert
      verify(
        mockApiConsumer.get(
          path: anyNamed('path'),
          queryParameters: {'limit': 10, 'page': 0},
        ),
      ).called(1);
    });

    test('should throw exception when API call fails', () async {
      // Arrange
      when(
        mockApiConsumer.get(
          path: anyNamed('path'),
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(() => dataSource.getBreeds(), throwsA(isA<Exception>()));

      verify(
        mockApiConsumer.get(
          path: anyNamed('path'),
          queryParameters: anyNamed('queryParameters'),
        ),
      ).called(1);
    });

    test('should throw exception when response format is invalid', () async {
      // Arrange
      when(
        mockApiConsumer.get(
          path: anyNamed('path'),
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer((_) async => 'invalid response');

      // Act & Assert
      expect(() => dataSource.getBreeds(), throwsA(isA<Exception>()));

      verify(
        mockApiConsumer.get(
          path: anyNamed('path'),
          queryParameters: anyNamed('queryParameters'),
        ),
      ).called(1);
    });

    test('should handle empty breeds list', () async {
      // Arrange
      when(
        mockApiConsumer.get(
          path: anyNamed('path'),
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer((_) async => <Map<String, dynamic>>[]);

      // Act
      final result = await dataSource.getBreeds();

      // Assert
      expect(result, isA<List<BreedModel>>());
      expect(result.length, equals(0));

      verify(
        mockApiConsumer.get(
          path: anyNamed('path'),
          queryParameters: anyNamed('queryParameters'),
        ),
      ).called(1);
    });
  });
}
