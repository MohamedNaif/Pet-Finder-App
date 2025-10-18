import 'package:pet_finder_app/core/api/api_consumer.dart';
import 'package:pet_finder_app/core/api/end_points.dart';
import 'package:pet_finder_app/features/home/data/models/breed_model.dart';

abstract class BreedRemoteDataSource {
  Future<List<BreedModel>> getBreeds({int limit = 10, int page = 0});
}

class BreedRemoteDataSourceImpl implements BreedRemoteDataSource {
  final ApiConsumer apiConsumer;

  BreedRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<BreedModel>> getBreeds({int limit = 10, int page = 0}) async {
    final response = await apiConsumer.get(
      path: EndPoints.breedsV1,
      queryParameters: {'limit': limit, 'page': page},
    );

    if (response is List) {
      return response.map((json) => BreedModel.fromJson(json)).toList();
    }

    throw Exception('Invalid response format');
  }
}
