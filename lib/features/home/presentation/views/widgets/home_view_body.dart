import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:inbox_iq/features/home/presentation/manager/daily_summary_cubit/daily_summary_cubit.dart';
import 'package:inbox_iq/features/home/presentation/manager/daily_summary_cubit/daily_summary_cubit_states.dart';
import 'package:inbox_iq/features/home/presentation/views/widgets/Inbox_stats_card.dart';
import 'package:inbox_iq/features/home/presentation/views/widgets/daily_summary_card.dart';
import 'package:inbox_iq/features/home/presentation/views/widgets/error_widget..dart';
import 'package:inbox_iq/features/home/presentation/views/widgets/home_header.dart';
import 'package:inbox_iq/features/home/presentation/views/widgets/sentiment_widget.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailySummaryCubit, DailySummaryState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<DailySummaryCubit>().refreshDailySummary();
          },
          child: SafeArea(
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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

                      // ✅ Loading State
                      if (state is DailySummaryLoading) _buildLoadingState(),

                      // ✅ Error State
                      if (state is DailySummaryError)
                        ErrorRetryWidget(
                          message: state.message,
                          onRetry: () {
                            context
                                .read<DailySummaryCubit>()
                                .fetchDailySummary();
                          },
                        ),

                      // ✅ Success State or Refreshing
                      if (state is DailySummaryLoaded ||
                          state is DailySummaryRefreshing) ...[
                        InboxStatsCard(
                          summary: state is DailySummaryLoaded
                              ? state.summary
                              : (state as DailySummaryRefreshing)
                                    .currentSummary,
                        ),
                        SizedBox(height: AppConstants.spacing16),
                        InboxMoodCard(
                          summary: state is DailySummaryLoaded
                              ? state.summary
                              : (state as DailySummaryRefreshing)
                                    .currentSummary,
                        ),
                        SizedBox(height: AppConstants.spacing16),
                        DailySummaryCard(
                          summary: state is DailySummaryLoaded
                              ? state.summary
                              : (state as DailySummaryRefreshing)
                                    .currentSummary,
                        ),
                      ],

                      SizedBox(height: AppConstants.spacing32),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(40.0),
        child: CircularProgressIndicator(),
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
