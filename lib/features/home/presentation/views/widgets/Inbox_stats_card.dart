import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:inbox_iq/features/home/presentation/widgets/stat_item.dart';

class InboxStatsCard extends StatelessWidget {
  final int emailCount;
  final int urgentCount;
  final int actionCount;
  final int readCount;

  const InboxStatsCard({
    super.key,
    required this.emailCount,
    required this.urgentCount,
    required this.actionCount,
    required this.readCount,
  });

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
          // Date
          Text(
            _getFormattedDate(),
            style: AppStyles.regular12(
              context,
            ).copyWith(color: Colors.white.withOpacity(0.9)),
          ),

          SizedBox(height: AppConstants.spacing16),

          // Email Count
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                emailCount.toString(),
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

          // Stats Row
          Row(
            children: [
              StatItem(
                icon: Icons.warning_amber_rounded,
                count: urgentCount,
                label: 'Urgent',
              ),
              SizedBox(width: AppConstants.spacing24),
              StatItem(
                icon: Icons.task_alt_rounded,
                count: actionCount,
                label: 'Actions',
              ),
              SizedBox(width: AppConstants.spacing24),
              StatItem(
                icon: Icons.mark_email_read_rounded,
                count: readCount,
                label: 'Read',
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  double _getCardPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 16.0;
    if (width < 600) return 20.0;
    return 24.0;
  }
}
