import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:pet_finder_app/core/api/api_consumer.dart';
import 'package:pet_finder_app/features/home/data/datasources/category_remote_data_source.dart';
import 'package:pet_finder_app/features/home/data/models/category_model.dart';

import 'category_remote_data_source_test.mocks.dart';

@GenerateMocks([ApiConsumer])
void main() {
  late CategoryRemoteDataSourceImpl dataSource;
  late MockApiConsumer mockApiConsumer;

  setUp(() {
    mockApiConsumer = MockApiConsumer();
    dataSource = CategoryRemoteDataSourceImpl(apiConsumer: mockApiConsumer);
  });

  group('CategoryRemoteDataSource', () {
    test(
      'should return list of categories when API call is successful',
      () async {
        // Arrange
        final categoriesJson = [
          {'id': 5, 'name': 'boxes'},
          {'id': 15, 'name': 'clothes'},
          {'id': 1, 'name': 'hats'},
        ];

        when(
          mockApiConsumer.get(path: anyNamed('path')),
        ).thenAnswer((_) async => categoriesJson);

        // Act
        final result = await dataSource.getCategories();

        // Assert
        expect(result, isA<List<CategoryModel>>());
        expect(result.length, equals(3));
        expect(result[0].id, equals(5));
        expect(result[0].name, equals('boxes'));
        expect(result[1].id, equals(15));
        expect(result[1].name, equals('clothes'));
        expect(result[2].id, equals(1));
        expect(result[2].name, equals('hats'));

        verify(mockApiConsumer.get(path: anyNamed('path'))).called(1);
      },
    );

    test('should throw exception when API call fails', () async {
      // Arrange
      when(
        mockApiConsumer.get(path: anyNamed('path')),
      ).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(() => dataSource.getCategories(), throwsA(isA<Exception>()));

      verify(mockApiConsumer.get(path: anyNamed('path'))).called(1);
    });

    test('should throw exception when response format is invalid', () async {
      // Arrange
      when(
        mockApiConsumer.get(path: anyNamed('path')),
      ).thenAnswer((_) async => 'invalid response');

      // Act & Assert
      expect(() => dataSource.getCategories(), throwsA(isA<Exception>()));

      verify(mockApiConsumer.get(path: anyNamed('path'))).called(1);
    });

    test('should handle empty categories list', () async {
      // Arrange
      when(
        mockApiConsumer.get(path: anyNamed('path')),
      ).thenAnswer((_) async => <Map<String, dynamic>>[]);

      // Act
      final result = await dataSource.getCategories();

      // Assert
      expect(result, isA<List<CategoryModel>>());
      expect(result.length, equals(0));

      verify(mockApiConsumer.get(path: anyNamed('path'))).called(1);
    });
  });
}
