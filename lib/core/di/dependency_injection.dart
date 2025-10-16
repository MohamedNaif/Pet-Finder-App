import 'package:dio/dio.dart';
import 'package:pet_finder_app/core/api/api_consumer.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_finder_app/core/api/dio_consumer.dart';


final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  // Dio Setup
  getIt.registerSingleton<Dio>(Dio());

  // ApiConsumer Setup
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: getIt<Dio>()),
  );
}
