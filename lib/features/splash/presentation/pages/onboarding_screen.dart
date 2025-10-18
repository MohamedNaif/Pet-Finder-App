import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_finder_app/core/constants/app_assets.dart';

import '../../../../config/routing/routes.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_style.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.petImage, width: 350, height: 350),
            SizedBox(height: 20),
            Text(
              "Find Your Best ",
              style: AppTextStyles.bold32.copyWith(color: AppColors.textMain),
              textAlign: TextAlign.center,
            ),
            Text(
              "Companion With Us",
              style: AppTextStyles.bold32.copyWith(color: AppColors.textMain),
              textAlign: TextAlign.center,
            ),
            Text(
              "Join & discover the best suitable pets as",
              style: AppTextStyles.regular16.copyWith(
                color: AppColors.textSubtle,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              " per your preferences in your location",
              style: AppTextStyles.regular16.copyWith(
                color: AppColors.textSubtle,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                context.go(Routes.home);
              },

              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 50),
                backgroundColor: Color(0xFF40B5B5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Get Started"),
                  SizedBox(width: 10),
                  SvgPicture.asset(AppAssets.petIcon),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
