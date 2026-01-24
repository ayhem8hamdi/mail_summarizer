// lib/features/home/presentation/views/widgets/shimmer/home_shimmer_loading.dart
import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:inbox_iq/features/home/presentation/views/shimmer_widgets/daily_summary_card.dart';
import 'package:inbox_iq/features/home/presentation/views/shimmer_widgets/shimmer_mood_card_widget.dart';
import 'package:inbox_iq/features/home/presentation/views/shimmer_widgets/shimmer_stats_card.dart';

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppConstants.spacing24),
        const InboxStatsCardShimmer(),
        SizedBox(height: AppConstants.spacing16),
        const InboxMoodCardShimmer(),
        SizedBox(height: AppConstants.spacing16),
        const DailySummaryCardShimmer(),
        SizedBox(height: AppConstants.spacing32),
      ],
    );
  }
}
