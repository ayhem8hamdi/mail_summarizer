import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inbox_iq/core/router/app_router.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
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
    Future.delayed(const Duration(seconds: splashDurationSeconds), () {
      if (mounted) {
        context.goNamed(AppRouter.onBoardingScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryBlue,
      body: SplashViewBody(),
    );
  }
}
