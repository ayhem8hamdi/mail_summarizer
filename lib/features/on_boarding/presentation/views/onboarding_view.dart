import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:inbox_iq/features/on_boarding/data/on_boarding_page_model.dart';
import 'package:inbox_iq/features/on_boarding/presentation/widgets/next_page_button.dart';
import 'package:inbox_iq/features/on_boarding/presentation/widgets/onboarding_page.dart';
import 'package:inbox_iq/features/on_boarding/presentation/widgets/page_dots.dart';
import 'package:inbox_iq/features/on_boarding/presentation/widgets/skip_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Define onboarding pages
  final List<OnboardingPageModel> _pages = [
    OnboardingPageModel(
      emoji: '✨',

      title: 'AI-Powered Intelligence',
      description:
          'Smart email analysis with sentiment detection, priority sorting, and automated categorization to help you focus on what matters most.',
    ),
    OnboardingPageModel(
      emoji: '⚡',

      title: 'Lightning-Fast Replies',
      description:
          'Generate perfect email responses in seconds with AI-powered smart replies. Record voice messages and let AI convert them to professional emails.',
    ),
    OnboardingPageModel(
      emoji: '🔒',

      title: 'Secure & Private',
      description:
          'Your data is protected with enterprise-grade security. We use OAuth 2.0 authentication and never store your emails on our servers.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: AppConstants.animationDuration,
        curve: AppConstants.animationCurve,
      );
    }
  }

  void _skipOnboarding() {
    if (_currentPage < _pages.length - 1) {
      _pageController.animateToPage(
        _pages.length - 1,
        duration: AppConstants.animationDuration,
        curve: AppConstants.animationCurve,
      );
    }
  }

  void _completeOnboarding() {
    // TODO: Navigate to home screen or login
    // Example:
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (_) => const HomeScreen()),
    // );
    debugPrint('Onboarding completed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SkipButtonWidget(
              onPressed: _skipOnboarding,
              isLastPage: _currentPage == _pages.length - 1,
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(pageModel: _pages[index]);
                },
              ),
            ),

            PageIndicatorWidget(
              pageCount: _pages.length,
              currentPage: _currentPage,
            ),

            SizedBox(height: AppConstants.spacing24),

            NextButtonWidget(
              onPressed: _nextPage,
              isLastPage: _currentPage == _pages.length - 1,
            ),

            SizedBox(height: AppConstants.spacing32),
          ],
        ),
      ),
    );
  }
}
