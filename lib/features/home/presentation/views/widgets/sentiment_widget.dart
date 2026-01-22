import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/core/utils/app_styles.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:inbox_iq/features/home/data/sentiments_enum.dart';
import 'package:inbox_iq/features/home/presentation/widgets/sentiment_progress_bar.dart';

class InboxMoodCard extends StatelessWidget {
  const InboxMoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - replace with actual data later
    const stats = SentimentStats.mockData;
    final dominantMood = _getDominantMood(stats);

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
          // Header with emoji
          Row(
            children: [
              // Emoji
              Text(
                dominantMood.emoji,
                style: TextStyle(fontSize: _getEmojiSize(context)),
              ),

              SizedBox(width: AppConstants.spacing16),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Inbox Mood: ${dominantMood.label}',
                      style: AppStyles.bold18(
                        context,
                      ).copyWith(color: dominantMood.color, fontSize: 15),
                    ),
                    SizedBox(height: AppConstants.spacing4),
                    Text(
                      'Most emails are neutral or positive today',
                      style: AppStyles.regular12(context).copyWith(
                        fontSize: 13,
                        color: Color(0XFFA2ACBA),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: AppConstants.spacing16),

          // Sentiment Progress Bar
          SentimentProgressBar(stats: stats),
        ],
      ),
    );
  }

  SentimentType _getDominantMood(SentimentStats stats) {
    if (stats.positiveCount >= stats.neutralCount &&
        stats.positiveCount >= stats.urgentCount) {
      return SentimentType.positive;
    } else if (stats.neutralCount >= stats.urgentCount) {
      return SentimentType.neutral;
    } else {
      return SentimentType.urgent;
    }
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
