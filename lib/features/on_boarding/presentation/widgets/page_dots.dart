import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/constants.dart';

class PageIndicatorWidget extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  const PageIndicatorWidget({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => _buildDot(index == currentPage),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return AnimatedContainer(
      duration: AppConstants.animationDuration,
      curve: AppConstants.animationCurve,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 24.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: isActive ? AppColors.kPrimaryBlue : AppColors.kBorderColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusButton),
      ),
    );
  }
}
