import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_finder_app/config/theme/app_colors.dart';
import 'package:pet_finder_app/core/constants/app_assets.dart';

class FilterIcon extends StatelessWidget {
  const FilterIcon({
    super.key,
    required this.onTap,
    this.svgIcon = AppAssets.filterIcon,
  });
  final Function()? onTap;
  final String svgIcon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white50,

          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grayscaleBorder),
        ),
        child: SvgPicture.asset(
          svgIcon,
          height: 24,
          colorFilter: ColorFilter.mode(AppColors.primary1, BlendMode.srcIn),
        ),
      ),
    );
  }
}
