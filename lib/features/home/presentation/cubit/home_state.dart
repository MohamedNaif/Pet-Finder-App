part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

// Categories States
class CategoriesLoading extends HomeState {}

class CategoriesLoaded extends HomeState {
  final List<CategoryModel> categories;

  const CategoriesLoaded({required this.categories});

  @override
  List<Object> get props => [categories];
}

class CategoriesError extends HomeState {
  final String message;

  const CategoriesError({required this.message});

  @override
  List<Object> get props => [message];
}

// Breeds States
class BreedsLoading extends HomeState {}

class BreedsLoaded extends HomeState {
  final List<BreedModel> breeds;

  const BreedsLoaded({required this.breeds});

  @override
  List<Object> get props => [breeds];
}

class BreedsError extends HomeState {
  final String message;

  const BreedsError({required this.message});

  @override
  List<Object> get props => [message];
}
