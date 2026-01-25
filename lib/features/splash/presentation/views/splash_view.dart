// lib/features/splash/presentation/views/splash_view.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inbox_iq/core/DI/di.dart';
import 'package:inbox_iq/core/router/app_router.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/features/on_boarding/data/repo/onboarding_status_use_case.dart';
import 'package:inbox_iq/features/splash/presentation/widgets/splash_screen_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  static const int splashDurationSeconds = 2;

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Wait for splash duration
    await Future.delayed(const Duration(seconds: splashDurationSeconds));

    if (!mounted) return;

    // Check if onboarding is completed using the use case
    final checkOnboardingStatusUseCase = sl<CheckOnboardingStatusUseCase>();
    final isOnboardingCompleted = await checkOnboardingStatusUseCase();

    if (isOnboardingCompleted) {
      // Skip onboarding and go directly to home
      context.goNamed(AppRouter.homeScreen);
    } else {
      // Show onboarding screen
      context.goNamed(AppRouter.onBoardingScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryBlue,
      body: SplashViewBody(),
    );
  }
}
