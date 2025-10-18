import 'package:flutter/material.dart';
import 'package:pet_finder_app/features/home/presentation/pages/pet_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
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
              const Text(
                'Your Favorite Pets',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              
              // Category Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryChip('All', true),
                    const SizedBox(width: 12),
                    _buildCategoryChip('Cats', false),
                    const SizedBox(width: 12),
                    _buildCategoryChip('Dogs', false),
                    const SizedBox(width: 12),
                    _buildCategoryChip('Birds', false),
                    const SizedBox(width: 12),
                    _buildCategoryChip('Fish', false),
                    const SizedBox(width: 12),
                    _buildCategoryChip('Reptiles', false),
                  ],
                ),
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

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
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
    );
  }

  Widget _buildPetCard(Map<String, dynamic> pet) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PetDetailScreen(pet: pet),
          ),
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
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                        pet['isFavorite'] ? Icons.favorite : Icons.favorite_border,
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
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
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
          _buildNavItem(Icons.chat_bubble_outline, Icons.chat_bubble, 2, currentIndex),
          _buildNavItem(Icons.person_outline, Icons.person, 3, currentIndex),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData outlinedIcon, IconData filledIcon, int index, int currentIndex) {
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