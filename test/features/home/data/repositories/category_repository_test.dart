import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:pet_finder_app/features/home/data/datasources/category_remote_data_source.dart';
import 'package:pet_finder_app/features/home/data/repositories/category_repository.dart';
import 'package:pet_finder_app/features/home/data/models/category_model.dart';

import 'category_repository_test.mocks.dart';

@GenerateMocks([CategoryRemoteDataSource])
void main() {
  late CategoryRepositoryImpl repository;
  late MockCategoryRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockCategoryRemoteDataSource();
    repository = CategoryRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('CategoryRepository', () {
    test('should return categories when remote data source succeeds', () async {
      // Arrange
      final categories = [
        CategoryModel(id: 5, name: 'boxes'),
        CategoryModel(id: 15, name: 'clothes'),
        CategoryModel(id: 1, name: 'hats'),
      ];

      when(
        mockRemoteDataSource.getCategories(),
      ).thenAnswer((_) async => categories);

      // Act
      final result = await repository.getCategories();

      // Assert
      expect(result, equals(categories));
      expect(result.length, equals(3));
      expect(result[0].name, equals('boxes'));
      expect(result[1].name, equals('clothes'));
      expect(result[2].name, equals('hats'));

      verify(mockRemoteDataSource.getCategories()).called(1);
    });

    test('should throw exception when remote data source fails', () async {
      // Arrange
      when(
        mockRemoteDataSource.getCategories(),
      ).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(() => repository.getCategories(), throwsA(isA<Exception>()));

      verify(mockRemoteDataSource.getCategories()).called(1);
    });

    test('should handle empty categories list', () async {
      // Arrange
      when(
        mockRemoteDataSource.getCategories(),
      ).thenAnswer((_) async => <CategoryModel>[]);

      // Act
      final result = await repository.getCategories();

      // Assert
      expect(result, isA<List<CategoryModel>>());
      expect(result.length, equals(0));

      verify(mockRemoteDataSource.getCategories()).called(1);
    });

    test('should propagate exceptions from remote data source', () async {
      // Arrange
      when(
        mockRemoteDataSource.getCategories(),
      ).thenThrow(Exception('API timeout'));

      // Act & Assert
      expect(
        () => repository.getCategories(),
        throwsA(predicate((e) => e.toString().contains('API timeout'))),
      );

      verify(mockRemoteDataSource.getCategories()).called(1);
    });
  });
}
