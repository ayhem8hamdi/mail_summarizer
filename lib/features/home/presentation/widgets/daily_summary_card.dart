import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';
import 'package:inbox_iq/core/utils/constants.dart';

class DailySummaryCard extends StatelessWidget {
  const DailySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - replace with actual data from API later
    const summaryText =
        'You have 2 urgent client requests, 2 meeting invitations, and 5 newsletters. Priority: Follow up with Sarah about project deadline.';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.kSurfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusCard),
        boxShadow: AppConstants.cardShadow,
      ),
      padding: EdgeInsets.all(_getCardPadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.kLightBlue,
                  borderRadius: BorderRadius.circular(
                    AppConstants.radiusButton,
                  ),
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: AppColors.kPrimaryBlue,
                  size: 20,
                ),
              ),

              SizedBox(width: AppConstants.spacing12),

              // Title
              Text('Daily Summary', style: AppStyles.regular15(context)),
            ],
          ),

          SizedBox(height: AppConstants.spacing12),

          // Summary Text
          Text(
            summaryText,
            style: AppStyles.regular12(
              context,
            ).copyWith(height: 1.6, fontSize: 14, fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }

  double _getCardPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 16.0;
    if (width < 600) return 20.0;
    return 24.0;
  }
}
