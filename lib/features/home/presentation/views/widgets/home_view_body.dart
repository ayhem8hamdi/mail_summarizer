import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:inbox_iq/features/home/presentation/widgets/Inbox_stats_card.dart';
import 'package:inbox_iq/features/home/presentation/widgets/daily_summary_card.dart';
import 'package:inbox_iq/features/home/presentation/widgets/home_header.dart';
import 'package:inbox_iq/features/home/presentation/widgets/sentiment_widget.dart'
    show InboxMoodCard;

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Header
          const SliverToBoxAdapter(child: HomeHeader()),

          // Content
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: _getHorizontalPadding(context),
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: AppConstants.spacing24),

                // Inbox Stats Card
                const InboxStatsCard(
                  emailCount: 5,
                  urgentCount: 4,
                  actionCount: 1,
                  readCount: 0,
                ),

                SizedBox(height: AppConstants.spacing16),

                // Inbox Mood Card
                const InboxMoodCard(),

                SizedBox(height: AppConstants.spacing16),

                // Daily Summary Card
                const DailySummaryCard(),

                SizedBox(height: AppConstants.spacing32),
              ]),
            ),
          ),
        ],
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
