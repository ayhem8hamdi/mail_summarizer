import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:inbox_iq/features/home/domain/entities/dailysummary_entity.dart';
import 'package:inbox_iq/features/home/domain/entities/mood_status_enum.dart';

class InboxMoodCard extends StatelessWidget {
  final DailySummary summary;

  const InboxMoodCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final mood = summary.mood;

    // Calculate percentages for the bar
    final total = summary.totalEmails > 0 ? summary.totalEmails : 1;
    final urgentPercent = summary.statistics.urgent / total;
    final normalPercent = summary.statistics.normal / total; // ✅ Changed
    final fyiPercent = summary.statistics.fyi / total; // ✅ Changed

    return Container(
      decoration: BoxDecoration(
        color: AppColors.kSurfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusCard),
        boxShadow: AppConstants.cardShadow,
      ),
      padding: EdgeInsets.all(_getCardPadding(context)),
      child: Row(
        children: [
          // Left side: Emoji
          Text(
            mood.status.emoji,
            style: TextStyle(fontSize: _getEmojiSize(context)),
          ),

          SizedBox(width: AppConstants.spacing16),

          // Right side: Text and Bar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Inbox Mood: ${mood.status.label}',
                  style: AppStyles.bold18(context).copyWith(
                    color: _getMoodTextColor(mood.status),
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: AppConstants.spacing4),

                // Description
                Text(
                  mood.description,
                  style: AppStyles.regular12(
                    context,
                  ).copyWith(fontSize: 12, color: const Color(0xFF64748B)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: AppConstants.spacing12),

                // Segmented Bar
                _buildSegmentedBar(
                  urgentPercent: urgentPercent,
                  normalPercent: normalPercent, // ✅ Changed parameter name
                  fyiPercent: fyiPercent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the segmented progress bar with 3 colors
  Widget _buildSegmentedBar({
    required double urgentPercent,
    required double normalPercent, // ✅ Changed parameter name
    required double fyiPercent,
  }) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.radiusButton),
        color: Colors.grey.shade200,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.radiusButton),
        child: Row(
          children: [
            // Urgent segment (Red)
            if (urgentPercent > 0)
              Expanded(
                flex: (urgentPercent * 100).toInt(),
                child: Container(color: AppColors.kUrgentRed),
              ),

            // Normal segment (Yellow)  // ✅ Updated comment
            if (normalPercent > 0) // ✅ Changed variable
              Expanded(
                flex: (normalPercent * 100).toInt(), // ✅ Changed variable
                child: Container(color: AppColors.kNeutralYellow),
              ),

            // FYI segment (Green)  // ✅ Updated comment
            if (fyiPercent > 0)
              Expanded(
                flex: (fyiPercent * 100).toInt(),
                child: Container(color: AppColors.kPositiveGreen),
              ),
          ],
        ),
      ),
    );
  }

  /// Returns text color for mood status
  Color _getMoodTextColor(MoodStatus status) {
    switch (status) {
      case MoodStatus.positive:
        return AppColors.kPositiveGreen;
      case MoodStatus.neutral:
        return AppColors.kNeutralYellow;
      case MoodStatus.urgent:
        return AppColors.kUrgentRed;
    }
  }

  double _getEmojiSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 40.0;
    if (width < 600) return 48.0;
    return 56.0;
  }

  double _getCardPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 16.0;
    if (width < 600) return 20.0;
    return 24.0;
  }
}
