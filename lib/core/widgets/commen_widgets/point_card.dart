import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_finder_app/config/theme/app_colors.dart';
import 'package:pet_finder_app/config/theme/app_style.dart';
import 'package:pet_finder_app/core/constants/app_assets.dart';

class PointsCard extends StatelessWidget {
  final int totalPoints;
  final int availablePoints;
  final List<CustomPointCard> cards;

  const PointsCard({
    super.key,
    required this.totalPoints,
    required this.availablePoints,
    this.cards = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 168,

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg-point-card.png'),
          fit: BoxFit.fill,
        ),
        // gradient: const LinearGradient(
        //   colors: [AppColors.primary900, AppColors.primary800],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Total Points
            Row(
              children: [
                SizedBox(
                  child: Image.asset(
                    AppAssets.tagPointCard,
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "إجمالي النقاط".tr(),
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.neutral200,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "$availablePoints ",
                          style: AppTextStyles.semiBold24.copyWith(
                            color: AppColors.neutral100,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "نقاط متاحة".tr(),
                          style: AppTextStyles.regular14.copyWith(
                            color: AppColors.neutral200,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: cards,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomPointCard extends StatelessWidget {
  final String title;
  final int points;
  final String svgPath;

  const CustomPointCard({
    super.key,
    required this.title,
    required this.points,
    required this.svgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.regular12.copyWith(
                    color: AppColors.neutral200,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$points",
                  style: AppTextStyles.medium20.copyWith(
                    color: AppColors.neutral100,
                  ),
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.neutral100,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                svgPath,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  AppColors.primary900,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
