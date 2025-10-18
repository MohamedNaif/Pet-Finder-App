import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pet_finder_app/config/theme/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSlider extends StatelessWidget {
  final List<Widget>? items;
  final double height;
  final CarouselSliderController controller;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final double viewportFraction;
  final bool autoPlay;

  const CustomSlider({
    super.key,
    required this.items,
    this.height = 175,
    required this.controller,
    this.onPageChanged,
    this.viewportFraction = 0.85,
    this.autoPlay = true,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: items!.length,
      itemBuilder: (context, index, realIndex) => items![index],
      carouselController: controller,
      options: CarouselOptions(
        viewportFraction: viewportFraction,
        height: height,
        onPageChanged: onPageChanged,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: autoPlay,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(seconds: 2),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    super.key,
    required this.currentPageIndex,
    required this.count,
    this.onDotClicked,
    this.dotHeight = 8,
    this.dotWidth = 16,
  });

  final int currentPageIndex;
  final int count;
  final dynamic Function(int)? onDotClicked;
  final double dotHeight;
  final double dotWidth;

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      onDotClicked: onDotClicked,
      duration: const Duration(milliseconds: 350),
      activeIndex: currentPageIndex,
      count: count,
      effect: ExpandingDotsEffect(
        spacing: 5,

        expansionFactor: 2.5,
        dotHeight: dotHeight,
        dotWidth: dotWidth,
        dotColor: AppColors.primary50,
        activeDotColor: AppColors.primary1,
      ),
    );
  }
}
