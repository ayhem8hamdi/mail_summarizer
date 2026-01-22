import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';
import 'package:inbox_iq/core/utils/constants.dart';

class ErrorRetryWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorRetryWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.kSurfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusCard),
        boxShadow: AppConstants.cardShadow,
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 48, color: AppColors.kUrgentRed),
          SizedBox(height: AppConstants.spacing16),
          Text('Oops!', style: AppStyles.bold18(context)),
          SizedBox(height: AppConstants.spacing8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppStyles.regular12(
              context,
            ).copyWith(color: const Color(0xFF64748B)),
          ),
          SizedBox(height: AppConstants.spacing24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kPrimaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
