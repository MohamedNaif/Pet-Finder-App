import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pet_finder_app/config/theme/app_colors.dart';
import 'package:pet_finder_app/config/theme/app_style.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAllPressed;

  const SectionHeader({
    super.key,
    required this.title,
    this.onViewAllPressed,
    this.isHaveMore = true,
  });
  final bool isHaveMore;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.semiBold16.copyWith(color: AppColors.textMain),
        ),
        if (isHaveMore)
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.topLeft,
            ),
            onPressed: onViewAllPressed,
            child: Text(
              'عرض الكل'.tr(),
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.primary1,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary1,
              ),
            ),
          ),
      ],
    );
  }
}
