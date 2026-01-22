import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:inbox_iq/features/home/domain/entities/dailysummary_entity.dart';

class DailySummaryCard extends StatelessWidget {
  final DailySummary summary;

  const DailySummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
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

          // Summary Text from API
          Text(
            summary.summary,
            style: AppStyles.regular12(
              context,
            ).copyWith(height: 1.6, fontSize: 14, fontWeight: FontWeight.w200),
          ),

          // Quick Actions
          if (summary.quickActions.isNotEmpty) ...[
            SizedBox(height: AppConstants.spacing16),
            const Divider(),
            SizedBox(height: AppConstants.spacing8),
            Text(
              'Quick Actions',
              style: AppStyles.bold18(context).copyWith(fontSize: 14),
            ),
            SizedBox(height: AppConstants.spacing8),
            ...summary.quickActions.map(
              (action) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Icon(
                      action.completed
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      size: 16,
                      color: action.completed
                          ? AppColors.kPositiveGreen
                          : AppColors.kNeutralYellow,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        action.task,
                        style: AppStyles.regular12(context).copyWith(
                          fontSize: 13,
                          decoration: action.completed
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
