import 'package:pet_finder_app/core/api/api_consumer.dart';
import 'package:pet_finder_app/core/api/end_points.dart';
import 'package:pet_finder_app/features/home/data/models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiConsumer apiConsumer;

  CategoryRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiConsumer.get(path: EndPoints.categoriesV1);

    if (response is List) {
      return response.map((json) => CategoryModel.fromJson(json)).toList();
    }

    throw Exception('Invalid response format');
  }
}
