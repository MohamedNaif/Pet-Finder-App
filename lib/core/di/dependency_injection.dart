import 'package:dio/dio.dart';
import 'package:pet_finder_app/core/api/api_consumer.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_finder_app/core/api/dio_consumer.dart';
import 'package:pet_finder_app/features/home/data/datasources/category_remote_data_source.dart';
import 'package:pet_finder_app/features/home/data/datasources/breed_remote_data_source.dart';
import 'package:pet_finder_app/features/home/data/repositories/category_repository.dart';
import 'package:pet_finder_app/features/home/data/repositories/breed_repository.dart';
import 'package:pet_finder_app/features/home/presentation/cubit/home_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  // Dio Setup
  getIt.registerSingleton<Dio>(Dio());

  // ApiConsumer Setup
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: getIt<Dio>()),
  );

  // Category Data Source
  getIt.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );

  // Category Repository
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remoteDataSource: getIt<CategoryRemoteDataSource>(),
    ),
  );

  // Breed Data Source
  getIt.registerLazySingleton<BreedRemoteDataSource>(
    () => BreedRemoteDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );

  // Breed Repository
  getIt.registerLazySingleton<BreedRepository>(
    () => BreedRepositoryImpl(remoteDataSource: getIt<BreedRemoteDataSource>()),
  );

  // Home Cubit
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      categoryRepository: getIt<CategoryRepository>(),
      breedRepository: getIt<BreedRepository>(),
    ),
  );
}
