// import 'dart:typed_data';
import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_finder_app/config/routing/routes.dart';
import 'package:pet_finder_app/features/splash/presentation/pages/onboarding_screen.dart';
import 'package:pet_finder_app/features/splash/presentation/pages/splash_screen.dart';

// import 'package:pet_finder_app/core/di/dependency_injection.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

CustomTransitionPage<void> _buildPageWithSlideTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required TextDirection? textDirection,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 600),
    reverseTransitionDuration: const Duration(milliseconds: 600),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const slideBegin = Offset(1.0, 0.0);
      const slideEnd = Offset.zero;
      const slideCurve = Curves.easeOutCubic;
      var slideTween = Tween(
        begin: slideBegin,
        end: slideEnd,
      ).chain(CurveTween(curve: slideCurve));
      var slideAnimation = animation.drive(slideTween);

      const fadeBegin = 1.0;
      const fadeEnd = 0.0;
      var fadeOutTween = Tween(
        begin: fadeBegin,
        end: fadeEnd,
      ).chain(CurveTween(curve: Curves.easeOutCubic));
      var fadeOutAnimation = secondaryAnimation.drive(fadeOutTween);

      return AnimatedBuilder(
        animation: secondaryAnimation,
        builder: (context, child) {
          return FadeTransition(
            opacity: fadeOutAnimation,
            child: SlideTransition(
              textDirection: textDirection ?? TextDirection.ltr,
              position: slideAnimation,
              child: child!,
            ),
          );
        },
        child: child,
      );
    },
  );
}

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,

  initialLocation: () {
    return Routes.splash;
  }(),

  routes: [
    GoRoute(
      path: Routes.splash,
      pageBuilder: (context, state) => _buildPageWithSlideTransition(
        context: context,
        state: state,
        child: const SplashScreen(),
        textDirection: TextDirection.rtl,
      ),
    ),
    GoRoute(
      path: Routes.onboardingScreen,
      pageBuilder: (context, state) => _buildPageWithSlideTransition(
        context: context,
        state: state,
        child: const OnboardingScreen(),
        textDirection: TextDirection.rtl,
      ),
    ),
    GoRoute(
      path: Routes.login,
      pageBuilder: (context, state) => _buildPageWithSlideTransition(
        context: context,
        state: state,
        child: const Scaffold(),
        textDirection: TextDirection.rtl,
      ),
    ),
    GoRoute(
      path: Routes.signup,
      pageBuilder: (context, state) => _buildPageWithSlideTransition(
        context: context,
        state: state,
        child: const Scaffold(),
        textDirection: TextDirection.rtl,
      ),
    ),
    //!============ END OF Notification ROUTES ======================================
    //!============ Start OF Home ROUTES ====================================
    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) => _buildPageWithSlideTransition(
        context: context,
        state: state,
        child: const Scaffold(),
        textDirection: TextDirection.rtl,
      ),
    ),
    
  ],
);
