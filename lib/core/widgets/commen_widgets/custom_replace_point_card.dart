import 'package:flutter/material.dart';
import 'package:pet_finder_app/config/theme/app_colors.dart';
import 'package:pet_finder_app/config/theme/app_style.dart';
import 'package:pet_finder_app/core/widgets/custom_button.dart';

class CustomReplacePointCard extends StatelessWidget {
  final int totalPoints;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onButtonTap;

  final Gradient? backgroundGradient;
  final String? topRightIcon;
  final String? bottomLeftIcon;
  final String? tagIcon;
  final bool hasReplaceBtn;

  const CustomReplacePointCard({
    super.key,
    required this.totalPoints,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onButtonTap,
    this.backgroundGradient,
    this.topRightIcon,
    this.bottomLeftIcon,
    this.tagIcon,
    this.hasReplaceBtn = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_container.png'),
          fit: BoxFit.fill,
        ),

        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (tagIcon != null)
                      Image.asset(tagIcon!, height: 40, width: 40),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.regular14.copyWith(
                            color: AppColors.neutral100,
                            height: 1.5,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "$totalPoints ",
                              style: AppTextStyles.bold28.copyWith(
                                color: AppColors.neutral100,

                                height: 1.5,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              subtitle,
                              style: AppTextStyles.regular14.copyWith(
                                color: AppColors.neutral100,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                if (hasReplaceBtn)
                  CustomButton(
                    widthPadding: 0,
                    height: 30,
                    width: 80,
                    onTap: onButtonTap,
                    text: buttonText,
                    textStyle: AppTextStyles.medium14.copyWith(
                      color: AppColors.primary1,
                    ),
                    color: AppColors.primary50,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
