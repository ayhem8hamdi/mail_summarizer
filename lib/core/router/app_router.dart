import 'package:go_router/go_router.dart';
import 'package:inbox_iq/features/on_boarding/presentation/views/onboarding_view.dart';
import 'package:inbox_iq/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  // Route names
  static const String splashScreen = 'splashScreen';
  static const String onBoardingScreen = 'onBoardingScreen';

  // Router
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        name: splashScreen,
        path: '/splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        name: onBoardingScreen,
        path: '/onBoarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
    ],
  );
}
