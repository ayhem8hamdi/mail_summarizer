import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';
import 'package:inbox_iq/core/utils/constants.dart';

class InboxErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const InboxErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColors.kUrgentRed),
          SizedBox(height: AppConstants.spacing16),
          Text('Oops!', style: AppStyles.bold18(context)),
          SizedBox(height: AppConstants.spacing8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppStyles.regular12(
              context,
            ).copyWith(color: const Color(0xFF64748B), fontSize: 14),
          ),
          SizedBox(height: AppConstants.spacing24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kPrimaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
