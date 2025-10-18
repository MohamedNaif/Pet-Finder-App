import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:pet_finder_app/core/widgets/carousel_slider.dart';
import 'package:pet_finder_app/core/widgets/custom_cached_image.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key, required this.images});

  final List<String> images;

  @override
  BannerSliderState createState() => BannerSliderState();
}

class BannerSliderState extends State<BannerSlider> {
  final _controller = CarouselSliderController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSlider(
          height: 170,
          items: widget.images.reversed
              .map((image) => CustomCachedImage(imagePath: image))
              .toList(),
          controller: _controller,
          onPageChanged: (index, reason) => setState(() {
            _currentPageIndex = index;
          }),
        ),
        if (widget.images.length > 1) ...[
          const SizedBox(height: 10),
          CustomIndicator(
            count: widget.images.length,
            currentPageIndex: _currentPageIndex,
            onDotClicked: (index) =>
                setState(() => _controller.animateToPage(index)),
          ),
        ],
      ],
    );
  }
}
