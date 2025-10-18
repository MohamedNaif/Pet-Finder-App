import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:pet_finder_app/features/home/data/datasources/breed_remote_data_source.dart';
import 'package:pet_finder_app/features/home/data/repositories/breed_repository.dart';
import 'package:pet_finder_app/features/home/data/models/breed_model.dart';

import 'breed_repository_test.mocks.dart';

@GenerateMocks([BreedRemoteDataSource])
void main() {
  late BreedRepositoryImpl repository;
  late MockBreedRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockBreedRemoteDataSource();
    repository = BreedRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('BreedRepository', () {
    test('should return breeds when remote data source succeeds', () async {
      // Arrange
      final breeds = [
        BreedModel(
          id: 'abys',
          name: 'Abyssinian',
          origin: 'Egypt',
          lifeSpan: '14 - 15',
          temperament: 'Active, Energetic, Independent',
          adaptability: 5,
          affectionLevel: 5,
        ),
        BreedModel(
          id: 'aege',
          name: 'Aegean',
          origin: 'Greece',
          lifeSpan: '9 - 12',
          temperament: 'Affectionate, Social, Intelligent',
          adaptability: 5,
          affectionLevel: 4,
        ),
      ];

      when(
        mockRemoteDataSource.getBreeds(limit: 10, page: 0),
      ).thenAnswer((_) async => breeds);

      // Act
      final result = await repository.getBreeds(limit: 10, page: 0);

      // Assert
      expect(result, equals(breeds));
      expect(result.length, equals(2));
      expect(result[0].name, equals('Abyssinian'));
      expect(result[0].origin, equals('Egypt'));
      expect(result[1].name, equals('Aegean'));
      expect(result[1].origin, equals('Greece'));

      verify(mockRemoteDataSource.getBreeds(limit: 10, page: 0)).called(1);
    });

    test('should use default parameters when not provided', () async {
      // Arrange
      when(
        mockRemoteDataSource.getBreeds(limit: 10, page: 0),
      ).thenAnswer((_) async => <BreedModel>[]);

      // Act
      await repository.getBreeds();

      // Assert
      verify(mockRemoteDataSource.getBreeds(limit: 10, page: 0)).called(1);
    });

    test('should throw exception when remote data source fails', () async {
      // Arrange
      when(
        mockRemoteDataSource.getBreeds(limit: 10, page: 0),
      ).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(() => repository.getBreeds(), throwsA(isA<Exception>()));

      verify(mockRemoteDataSource.getBreeds(limit: 10, page: 0)).called(1);
    });

    test('should handle empty breeds list', () async {
      // Arrange
      when(
        mockRemoteDataSource.getBreeds(limit: 10, page: 0),
      ).thenAnswer((_) async => <BreedModel>[]);

      // Act
      final result = await repository.getBreeds();

      // Assert
      expect(result, isA<List<BreedModel>>());
      expect(result.length, equals(0));

      verify(mockRemoteDataSource.getBreeds(limit: 10, page: 0)).called(1);
    });

    test('should propagate exceptions from remote data source', () async {
      // Arrange
      when(
        mockRemoteDataSource.getBreeds(limit: 10, page: 0),
      ).thenThrow(Exception('API timeout'));

      // Act & Assert
      expect(
        () => repository.getBreeds(),
        throwsA(predicate((e) => e.toString().contains('API timeout'))),
      );

      verify(mockRemoteDataSource.getBreeds(limit: 10, page: 0)).called(1);
    });

    test('should pass custom limit and page parameters', () async {
      // Arrange
      when(
        mockRemoteDataSource.getBreeds(limit: 20, page: 2),
      ).thenAnswer((_) async => <BreedModel>[]);

      // Act
      await repository.getBreeds(limit: 20, page: 2);

      // Assert
      verify(mockRemoteDataSource.getBreeds(limit: 20, page: 2)).called(1);
    });
  });
}
