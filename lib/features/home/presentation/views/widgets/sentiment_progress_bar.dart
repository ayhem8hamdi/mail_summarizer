import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:inbox_iq/features/home/data/sentiments_enum.dart';

class SentimentProgressBar extends StatelessWidget {
  final SentimentStats stats;

  const SentimentProgressBar({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusButton),
            child: SizedBox(
              height: 8,
              child: Row(
                children: [
                  // Positive section
                  if (stats.positiveCount > 0)
                    Expanded(
                      flex: stats.positiveCount,
                      child: Container(color: SentimentType.positive.color),
                    ),

                  // Neutral section
                  if (stats.neutralCount > 0)
                    Expanded(
                      flex: stats.neutralCount,
                      child: Container(color: SentimentType.neutral.color),
                    ),

                  // Urgent section
                  if (stats.urgentCount > 0)
                    Expanded(
                      flex: stats.urgentCount,
                      child: Container(color: SentimentType.urgent.color),
                    ),
                ],
              ),
            ),
          ),

          SizedBox(height: AppConstants.spacing12),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _LegendItem(
                type: SentimentType.positive,
                count: stats.positiveCount,
              ),
              _LegendItem(
                type: SentimentType.neutral,
                count: stats.neutralCount,
              ),
              _LegendItem(type: SentimentType.urgent, count: stats.urgentCount),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final SentimentType type;
  final int count;

  const _LegendItem({required this.type, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: type.color, shape: BoxShape.circle),
        ),
        SizedBox(width: AppConstants.spacing4),
        Text(
          '$count ${type.label}',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}
