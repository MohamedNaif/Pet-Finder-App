import 'package:pet_finder_app/features/home/data/datasources/category_remote_data_source.dart';
import 'package:pet_finder_app/features/home/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      return await remoteDataSource.getCategories();
    } catch (e) {
      rethrow;
    }
  }
}
