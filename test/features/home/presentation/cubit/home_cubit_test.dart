import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:pet_finder_app/features/home/data/models/category_model.dart';
import 'package:pet_finder_app/features/home/data/models/breed_model.dart';
import 'package:pet_finder_app/features/home/data/repositories/category_repository.dart';
import 'package:pet_finder_app/features/home/data/repositories/breed_repository.dart';
import 'package:pet_finder_app/features/home/presentation/cubit/home_cubit.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([CategoryRepository, BreedRepository])
void main() {
  late HomeCubit homeCubit;
  late MockCategoryRepository mockCategoryRepository;
  late MockBreedRepository mockBreedRepository;

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    mockBreedRepository = MockBreedRepository();
    homeCubit = HomeCubit(
      categoryRepository: mockCategoryRepository,
      breedRepository: mockBreedRepository,
    );
  });

  tearDown(() {
    homeCubit.close();
  });

  group('HomeCubit', () {
    test('initial state should be HomeInitial', () {
      // Assert
      expect(homeCubit.state, isA<HomeInitial>());
    });

    group('getCategories', () {
      final categories = [
        CategoryModel(id: 5, name: 'boxes'),
        CategoryModel(id: 15, name: 'clothes'),
        CategoryModel(id: 1, name: 'hats'),
      ];

      blocTest<HomeCubit, HomeState>(
        'should emit [CategoriesLoading, CategoriesLoaded] when getCategories succeeds',
        build: () {
          when(
            mockCategoryRepository.getCategories(),
          ).thenAnswer((_) async => categories);
          return homeCubit;
        },
        act: (cubit) => cubit.getCategories(),
        expect: () => [
          isA<CategoriesLoading>(),
          isA<CategoriesLoaded>().having(
            (state) => state.categories,
            'categories',
            categories,
          ),
        ],
        verify: (_) {
          verify(mockCategoryRepository.getCategories()).called(1);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'should emit [CategoriesLoading, CategoriesError] when getCategories fails',
        build: () {
          when(
            mockCategoryRepository.getCategories(),
          ).thenThrow(Exception('Network error'));
          return homeCubit;
        },
        act: (cubit) => cubit.getCategories(),
        expect: () => [
          isA<CategoriesLoading>(),
          isA<CategoriesError>().having(
            (state) => state.message,
            'message',
            contains('Network error'),
          ),
        ],
        verify: (_) {
          verify(mockCategoryRepository.getCategories()).called(1);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'should handle empty categories list',
        build: () {
          when(
            mockCategoryRepository.getCategories(),
          ).thenAnswer((_) async => <CategoryModel>[]);
          return homeCubit;
        },
        act: (cubit) => cubit.getCategories(),
        expect: () => [
          isA<CategoriesLoading>(),
          isA<CategoriesLoaded>().having(
            (state) => state.categories.length,
            'categories length',
            0,
          ),
        ],
        verify: (_) {
          verify(mockCategoryRepository.getCategories()).called(1);
        },
      );
    });

    group('getBreeds', () {
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

      blocTest<HomeCubit, HomeState>(
        'should emit [BreedsLoading, BreedsLoaded] when getBreeds succeeds',
        build: () {
          when(
            mockBreedRepository.getBreeds(limit: 10, page: 0),
          ).thenAnswer((_) async => breeds);
          return homeCubit;
        },
        act: (cubit) => cubit.getBreeds(limit: 10, page: 0),
        expect: () => [
          isA<BreedsLoading>(),
          isA<BreedsLoaded>().having((state) => state.breeds, 'breeds', breeds),
        ],
        verify: (_) {
          verify(mockBreedRepository.getBreeds(limit: 10, page: 0)).called(1);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'should emit [BreedsLoading, BreedsError] when getBreeds fails',
        build: () {
          when(
            mockBreedRepository.getBreeds(limit: 10, page: 0),
          ).thenThrow(Exception('Network error'));
          return homeCubit;
        },
        act: (cubit) => cubit.getBreeds(limit: 10, page: 0),
        expect: () => [
          isA<BreedsLoading>(),
          isA<BreedsError>().having(
            (state) => state.message,
            'message',
            contains('Network error'),
          ),
        ],
        verify: (_) {
          verify(mockBreedRepository.getBreeds(limit: 10, page: 0)).called(1);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'should use default parameters when not provided',
        build: () {
          when(
            mockBreedRepository.getBreeds(limit: 10, page: 0),
          ).thenAnswer((_) async => <BreedModel>[]);
          return homeCubit;
        },
        act: (cubit) => cubit.getBreeds(),
        expect: () => [
          isA<BreedsLoading>(),
          isA<BreedsLoaded>().having(
            (state) => state.breeds.length,
            'breeds length',
            0,
          ),
        ],
        verify: (_) {
          verify(mockBreedRepository.getBreeds(limit: 10, page: 0)).called(1);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'should handle custom limit and page parameters',
        build: () {
          when(
            mockBreedRepository.getBreeds(limit: 20, page: 2),
          ).thenAnswer((_) async => <BreedModel>[]);
          return homeCubit;
        },
        act: (cubit) => cubit.getBreeds(limit: 20, page: 2),
        expect: () => [
          isA<BreedsLoading>(),
          isA<BreedsLoaded>().having(
            (state) => state.breeds.length,
            'breeds length',
            0,
          ),
        ],
        verify: (_) {
          verify(mockBreedRepository.getBreeds(limit: 20, page: 2)).called(1);
        },
      );
    });

    group('multiple operations', () {
      blocTest<HomeCubit, HomeState>(
        'should handle multiple getCategories calls',
        build: () {
          when(
            mockCategoryRepository.getCategories(),
          ).thenAnswer((_) async => [CategoryModel(id: 1, name: 'test')]);
          return homeCubit;
        },
        act: (cubit) async {
          await cubit.getCategories();
          await cubit.getCategories();
        },
        expect: () => [
          isA<CategoriesLoading>(),
          isA<CategoriesLoaded>(),
          isA<CategoriesLoading>(),
          isA<CategoriesLoaded>(),
        ],
        verify: (_) {
          verify(mockCategoryRepository.getCategories()).called(2);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'should handle getCategories and getBreeds calls independently',
        build: () {
          when(
            mockCategoryRepository.getCategories(),
          ).thenAnswer((_) async => [CategoryModel(id: 1, name: 'test')]);
          when(mockBreedRepository.getBreeds(limit: 10, page: 0)).thenAnswer(
            (_) async => [BreedModel(id: 'test', name: 'Test Breed')],
          );
          return homeCubit;
        },
        act: (cubit) async {
          await cubit.getCategories();
          await cubit.getBreeds();
        },
        expect: () => [
          isA<CategoriesLoading>(),
          isA<CategoriesLoaded>(),
          isA<BreedsLoading>(),
          isA<BreedsLoaded>(),
        ],
        verify: (_) {
          verify(mockCategoryRepository.getCategories()).called(1);
          verify(mockBreedRepository.getBreeds(limit: 10, page: 0)).called(1);
        },
      );
    });
  });
}
