import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_finder_app/config/routing/routes.dart';
import 'package:pet_finder_app/core/constants/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  /// Navigates to the login screen after a delay.
  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        context.go(Routes.onboardingScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the background color to the primary app color.
      backgroundColor: Colors.white,
      body: Center(
        // Display the logo in the center of the screen.
        child: Image.asset(AppAssets.logo, width: 220), // Adjust width as needed
      ),
    );
  }
}
