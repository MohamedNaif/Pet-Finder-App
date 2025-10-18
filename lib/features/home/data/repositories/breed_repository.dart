import 'package:pet_finder_app/features/home/data/datasources/breed_remote_data_source.dart';
import 'package:pet_finder_app/features/home/data/models/breed_model.dart';

abstract class BreedRepository {
  Future<List<BreedModel>> getBreeds({int limit = 10, int page = 0});
}

class BreedRepositoryImpl implements BreedRepository {
  final BreedRemoteDataSource remoteDataSource;

  BreedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<BreedModel>> getBreeds({int limit = 10, int page = 0}) async {
    try {
      return await remoteDataSource.getBreeds(limit: limit, page: page);
    } catch (e) {
      rethrow;
    }
  }
}
