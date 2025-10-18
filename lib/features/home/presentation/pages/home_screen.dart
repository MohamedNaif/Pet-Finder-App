import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_finder_app/config/theme/app_style.dart';
import 'package:pet_finder_app/core/di/dependency_injection.dart';
import 'package:pet_finder_app/core/widgets/custom_text_form_field.dart';
import 'package:pet_finder_app/features/home/data/models/category_model.dart';
import 'package:pet_finder_app/features/home/data/models/breed_model.dart';
import 'package:pet_finder_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:pet_finder_app/features/home/presentation/pages/pet_detail_screen.dart';

import '../../../../config/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()
        ..getCategories()
        ..getBreeds(limit: 10, page: 0),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  String? selectedCategory;
  String? selectedBreed;
  final List<Map<String, dynamic>> pets = [
    {
      'name': 'Joli',
      'distance': '1.6 km away',
      'image': 'cat',
      'isFavorite': true,
    },
    {
      'name': 'Oliver',
      'distance': '2 km away',
      'image': 'bird',
      'isFavorite': false,
    },
    {
      'name': 'Tom',
      'distance': '2.7 km away',
      'image': 'dog',
      'isFavorite': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Find Your Forever Pet',
                style: AppTextStyles.bold28.copyWith(color: AppColors.textMain),
              ),
              const SizedBox(height: 20),
              // Search Bar
              CustomTextFormField(
                obscureText: false,
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.tune),
              ),
              const SizedBox(height: 20),
              Text(
                'Categories',
                style: AppTextStyles.bold20.copyWith(color: AppColors.textMain),
              ),
              const SizedBox(height: 20),

              // Category Chips - Dynamic from API
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) =>
                    previous is CategoriesLoading ||
                    previous is CategoriesLoaded ||
                    previous is CategoriesError ||
                    current is CategoriesLoading ||
                    current is CategoriesLoaded ||
                    current is CategoriesError,
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return _buildLoadingCategories();
                  } else if (state is CategoriesLoaded) {
                    return _buildCategoriesList(state.categories);
                  } else if (state is CategoriesError) {
                    return _buildErrorCategories(state.message);
                  }
                  return context.read<HomeCubit>().categoriesData.isEmpty
                      ? _buildLoadingCategories()
                      : _buildCategoriesList(
                          context.read<HomeCubit>().categoriesData,
                        );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Popular Breeds',
                style: AppTextStyles.bold20.copyWith(color: AppColors.textMain),
              ),
              const SizedBox(height: 16),

              // Breeds Section
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) =>
                    previous is BreedsLoading ||
                    previous is BreedsLoaded ||
                    previous is BreedsError ||
                    current is BreedsLoading ||
                    current is BreedsLoaded ||
                    current is BreedsError,
                builder: (context, state) {
                  (previous, current) =>
                      previous is BreedsLoading ||
                      previous is BreedsLoaded ||
                      previous is BreedsError ||
                      current is BreedsLoading ||
                      current is BreedsLoaded ||
                      current is BreedsError;
                  if (state is BreedsLoading) {
                    return _buildLoadingBreeds();
                  } else if (state is BreedsLoaded) {
                    return _buildBreedsList(state.breeds);
                  } else if (state is BreedsError) {
                    return _buildErrorBreeds(state.message);
                  }
                  return context.read<HomeCubit>().breedsData.isEmpty
                      ? _buildLoadingBreeds()
                      : _buildBreedsList(
                          context.read<HomeCubit>().breedsData,
                        );
                },
              ),
              const SizedBox(height: 24),

              // Pet Cards
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildPetCard(pets[0])),
                        const SizedBox(width: 16),
                        Expanded(child: _buildPetCard(pets[1])),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildPetCard(pets[2])),
                        const SizedBox(width: 16),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(0),
    );
  }

  // Loading shimmer for categories
  Widget _buildLoadingCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Categories list from API
  Widget _buildCategoriesList(List<CategoryModel> categories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // "All" category
          _buildCategoryChip('All', selectedCategory == null),
          const SizedBox(width: 12),
          // Dynamic categories from API
          ...categories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _buildCategoryChip(
                category.name,
                selectedCategory == category.name,
                onTap: () {
                  setState(() {
                    selectedCategory = category.name;
                  });
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  // Error widget with retry
  Widget _buildErrorCategories(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Failed to load categories',
              style: TextStyle(color: Colors.red.shade700, fontSize: 12),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<HomeCubit>().getCategories();
            },
            child: const Text('Retry', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
    String label,
    bool isSelected, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            setState(() {
              selectedCategory = null;
            });
          },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4DB6AC) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF4DB6AC) : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // Loading shimmer for breeds
  Widget _buildLoadingBreeds() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }

  // Breeds list from API
  Widget _buildBreedsList(List<BreedModel> breeds) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: breeds.length,
        itemBuilder: (context, index) {
          final breed = breeds[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedBreed = breed.name;
              });
            },
            child: Container(
              width: 100,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: selectedBreed == breed.name
                    ? const Color(0xFF4DB6AC)
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedBreed == breed.name
                      ? const Color(0xFF4DB6AC)
                      : Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pets,
                    size: 32,
                    color: selectedBreed == breed.name
                        ? Colors.white
                        : Colors.grey[600],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      breed.name,
                      style: TextStyle(
                        color: selectedBreed == breed.name
                            ? Colors.white
                            : Colors.grey[700],
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Error widget for breeds
  Widget _buildErrorBreeds(String message) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Failed to load breeds',
              style: TextStyle(color: Colors.red.shade700, fontSize: 12),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<HomeCubit>().getBreeds(limit: 10, page: 0);
            },
            child: const Text('Retry', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildPetCard(Map<String, dynamic> pet) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PetDetailScreen(pet: pet)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE0F2F1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pet Image
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: const Color(0xFFB2DFDB),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Icon(
                  pet['image'] == 'cat'
                      ? Icons.pets
                      : pet['image'] == 'bird'
                      ? Icons.flutter_dash
                      : Icons.pets,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pet['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        pet['isFavorite']
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: const Color(0xFF4DB6AC),
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.red[400]),
                      const SizedBox(width: 4),
                      Text(
                        pet['distance'],
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(int currentIndex) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, Icons.home, 0, currentIndex),
          _buildNavItem(Icons.favorite_border, Icons.favorite, 1, currentIndex),
          _buildNavItem(
            Icons.chat_bubble_outline,
            Icons.chat_bubble,
            2,
            currentIndex,
          ),
          _buildNavItem(Icons.person_outline, Icons.person, 3, currentIndex),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData outlinedIcon,
    IconData filledIcon,
    int index,
    int currentIndex,
  ) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/pet-list');
        }
      },
      child: Icon(
        isSelected ? filledIcon : outlinedIcon,
        color: isSelected ? const Color(0xFF4DB6AC) : Colors.grey[400],
        size: 28,
      ),
    );
  }
}
