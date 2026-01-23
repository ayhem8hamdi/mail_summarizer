import 'package:go_router/go_router.dart';
import 'package:inbox_iq/core/utils/bottom_nav_bar.dart';
import 'package:inbox_iq/features/home/presentation/views/home_view.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';
import 'package:inbox_iq/features/inbox/presentation/views/inbox_view.dart';
import 'package:inbox_iq/features/inbox/presentation/views/inbox_details_view.dart';
import 'package:inbox_iq/features/on_boarding/presentation/views/onboarding_view.dart';
import 'package:inbox_iq/features/settings/presentation/views/settings_view.dart';
import 'package:inbox_iq/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  // Route names
  static const String splashScreen = 'splashScreen';
  static const String onBoardingScreen = 'onBoardingScreen';
  static const String homeScreen = 'homeScreen';
  static const String inboxScreen = 'inboxScreen';
  static const String inboxDetailsScreen = 'inboxDetailsScreen'; // ← NEW
  static const String settingsScreen = 'settingsScreen';

  // Router
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      // Global Navigation
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

      // ✅ Inbox Details Screen (Outside Bottom Nav)
      GoRoute(
        name: inboxDetailsScreen,
        path: '/inbox/:emailId',
        builder: (context, state) {
          final email = state.extra as EmailEntity;
          return InboxDetailsView(email: email);
        },
      ),

      // Bottom Navigation Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            BottomNavShell(navigationShell: navigationShell),
        branches: [
          // Home Tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: homeScreen,
                path: '/home',
                builder: (context, state) => const HomeView(),
              ),
            ],
          ),

          // Inbox Tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: inboxScreen,
                path: '/inbox',
                builder: (context, state) => const InboxView(),
              ),
            ],
          ),

          // Settings Tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: settingsScreen,
                path: '/settings',
                builder: (context, state) => const SettingsView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
