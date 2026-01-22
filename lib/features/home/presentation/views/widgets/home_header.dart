import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:intl/intl.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  String _getFormattedDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, MMM d').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(context),
        vertical: AppConstants.spacing16,
      ),
      decoration: const BoxDecoration(color: AppColors.kSurfaceColor),
      child: Row(
        children: [
          // Logo
          _buildLogo(),

          SizedBox(width: AppConstants.spacing12),

          // App Name and Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'InboxIQ',
                  style: AppStyles.bold18(context).copyWith(fontSize: 16),
                ),
                const SizedBox(height: 1),
                Text(
                  _getFormattedDate(),
                  style: AppStyles.regular8(context).copyWith(fontSize: 9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        gradient: AppColors.kPrimaryGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusButton),
        boxShadow: [
          BoxShadow(
            color: AppColors.kShadowPrimary,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'IQ',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  double _getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 16.0;
    if (width < 600) return 20.0;
    return 24.0;
  }
}
