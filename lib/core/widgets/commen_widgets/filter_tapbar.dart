import 'package:flutter/material.dart';
import 'package:pet_finder_app/config/theme/app_colors.dart';
import 'package:pet_finder_app/config/theme/app_style.dart';

class FilterTabBar extends StatefulWidget {
  final List<String> labels;
  final ValueChanged<int>? onTap;

  const FilterTabBar({super.key, required this.labels, this.onTap});

  @override
  State<FilterTabBar> createState() => _FilterTabBarState();
}

class _FilterTabBarState extends State<FilterTabBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.labels.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 35,
            child: TabBar(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                if (widget.onTap != null) {
                  widget.onTap!(index);
                }
              },
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              splashBorderRadius: BorderRadius.circular(8),
              dividerColor: Colors.transparent,
              unselectedLabelColor: AppColors.textMain,
              labelColor: AppColors.white,
              labelStyle: AppTextStyles.medium14.copyWith(
                color: AppColors.white,
              ),
              unselectedLabelStyle: AppTextStyles.medium14.copyWith(
                color: AppColors.textSubtle,
              ),
              indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.primary600, AppColors.primary700],
                ),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              tabs: List.generate(widget.labels.length, (index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),

                    color: _selectedIndex == index
                        ? Colors.transparent
                        : AppColors.grayscaleBackground,
                  ),
                  child: Tab(text: widget.labels[index]),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
