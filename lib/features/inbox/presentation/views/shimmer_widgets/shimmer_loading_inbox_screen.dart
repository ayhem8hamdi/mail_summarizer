// lib/features/inbox/presentation/views/widgets/inbox_shimmer_loading.dart
import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:inbox_iq/features/inbox/presentation/views/shimmer_widgets/shimmer_email_card.dart';
import 'package:inbox_iq/features/inbox/presentation/views/shimmer_widgets/shimmer_filter_ship.dart';

class InboxShimmerLoading extends StatelessWidget {
  const InboxShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          // Title
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _getHorizontalPadding(context),
                vertical: 16,
              ),
              child: const Text(
                'Priority Inbox',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
          ),

          // Filter Chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: _getHorizontalPadding(context),
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  // Vary the widths for a more realistic look
                  final widths = [80.0, 100.0, 95.0, 75.0];
                  return ShimmerFilterChip(width: widths[index]);
                },
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: AppConstants.spacing16)),

          // Email Cards
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: _getHorizontalPadding(context),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const ShimmerEmailCard(),
                childCount: 10, // Show 10 shimmer cards
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: AppConstants.spacing24)),
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
