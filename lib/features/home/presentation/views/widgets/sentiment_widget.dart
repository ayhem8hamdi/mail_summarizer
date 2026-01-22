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
          // Header with emoji from API
          Row(
            children: [
              // Emoji from API
              Text(
                mood.status.emoji,
                style: TextStyle(fontSize: _getEmojiSize(context)),
              ),

              SizedBox(width: AppConstants.spacing16),

              // Text from API
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Inbox Mood: ${mood.status.label}',
                      style: AppStyles.bold18(context).copyWith(
                        color: getMoodColor(mood.status),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppConstants.spacing4),
                    Text(
                      mood.description,
                      style: AppStyles.regular12(context).copyWith(
                        fontSize: 13,
                        color: const Color(0XFFA2ACBA),
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: AppConstants.spacing16),

          // Mood Score Bar
          _buildMoodScoreBar(mood.score),
        ],
      ),
    );
  }

  Widget _buildMoodScoreBar(double score) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mood Score: ${(score * 100).toInt()}%',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.radiusButton),
          child: LinearProgressIndicator(
            value: score,
            minHeight: 8,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(_getScoreColor(score)),
          ),
        ),
      ],
    );
  }

  Color getMoodColor(MoodStatus status) {
    switch (status) {
      case MoodStatus.positive:
        return AppColors.kPositiveGreen;
      case MoodStatus.neutral:
        return AppColors.kNeutralYellow;
      case MoodStatus.urgent:
        return AppColors.kUrgentRed;
    }
  }

  Color _getScoreColor(double score) {
    if (score >= 0.7) return AppColors.kPositiveGreen;
    if (score >= 0.4) return AppColors.kNeutralYellow;
    return AppColors.kUrgentRed;
  }

  double _getCardPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 16.0;
    if (width < 600) return 20.0;
    return 24.0;
  }

  double _getEmojiSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return 40.0;
    if (width < 600) return 48.0;
    return 56.0;
  }
}
