import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:inbox_iq/features/home/domain/entities/dailysummary_entity.dart';
import 'package:inbox_iq/features/home/presentation/views/widgets/stat_item.dart';

class InboxStatsCard extends StatelessWidget {
  final DailySummary summary;

  const InboxStatsCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.kPrimaryGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusCard),
        boxShadow: AppConstants.buttonShadow,
      ),
      padding: EdgeInsets.all(_getCardPadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date from API
          Text(
            summary.date,
            style: AppStyles.regular12(
              context,
            ).copyWith(color: Colors.white.withOpacity(0.9)),
          ),

          SizedBox(height: AppConstants.spacing16),

          // Email Count from API
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                summary.totalEmails.toString(),
                style: AppStyles.semiBold20(
                  context,
                ).copyWith(fontSize: 36, color: Colors.white),
              ),
              SizedBox(width: AppConstants.spacing8),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Emails Today',
                  style: AppStyles.bold18(
                    context,
                  ).copyWith(color: Colors.white, fontSize: 13),
                ),
              ),
            ],
          ),

          SizedBox(height: AppConstants.spacing16),

          // ✅ Updated Stats Row - Show Urgent, Normal, FYI
          Row(
            children: [
              StatItem(
                icon: Icons.warning_amber_rounded,
                count: summary.statistics.urgent,
                label: 'Urgent',
              ),
              SizedBox(width: AppConstants.spacing24),
              StatItem(
                icon: Icons.email_rounded, // ✅ Changed icon
                count: summary.statistics.normal, // ✅ Changed to normal
                label: 'Normal', // ✅ Changed label
              ),
              SizedBox(width: AppConstants.spacing24),
              StatItem(
                icon: Icons.info_outline_rounded, // ✅ Changed icon
                count: summary.statistics.fyi,
                label: 'FYI', // ✅ Changed label
              ),
            ],
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
