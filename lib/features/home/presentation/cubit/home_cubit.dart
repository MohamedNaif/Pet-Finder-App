import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_finder_app/features/home/data/models/category_model.dart';
import 'package:pet_finder_app/features/home/data/models/breed_model.dart';
import 'package:pet_finder_app/features/home/data/repositories/category_repository.dart';
import 'package:pet_finder_app/features/home/data/repositories/breed_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CategoryRepository categoryRepository;
  final BreedRepository breedRepository;

  HomeCubit({required this.categoryRepository, required this.breedRepository})
    : super(HomeInitial());


    List<CategoryModel> categoriesData = [];
    List<BreedModel> breedsData = [];

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    try {
      final categories = await categoryRepository.getCategories();
      emit(CategoriesLoaded(categories: categories));
      categoriesData = categories;
    } catch (e) {
      emit(CategoriesError(message: e.toString()));
    }
  }

  Future<void> getBreeds({int limit = 10, int page = 0}) async {
    emit(BreedsLoading());
    try {
      final breeds = await breedRepository.getBreeds(limit: limit, page: page);
      emit(BreedsLoaded(breeds: breeds));
      breedsData = breeds;
    } catch (e) {
      emit(BreedsError(message: e.toString()));
    }
  }
}
