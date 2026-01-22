import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';
import 'package:inbox_iq/core/utils/constants.dart';

class SkipButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLastPage;

  const SkipButtonWidget({
    super.key,
    required this.onPressed,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    if (isLastPage) {
      return SizedBox(height: AppConstants.minTouchTarget);
    }

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
          top: AppConstants.spacing16,
          right: _getHorizontalPadding(context),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            minimumSize: const Size(60, AppConstants.minTouchTarget),
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.spacing16,
              vertical: AppConstants.spacing12,
            ),
            foregroundColor: AppColors.kTextSecondary,
          ),
          child: Text(
            'Skip',
            style: AppStyles.semiBold12(
              context,
            ).copyWith(color: AppColors.kTextSecondary),
          ),
        ),
      ),
    );
  }

  /// Get responsive horizontal padding
  double _getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 16.0;
    if (width < 600) return 20.0;
    return 24.0;
  }
}
