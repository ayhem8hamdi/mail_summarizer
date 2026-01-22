import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:inbox_iq/features/inbox/data/email_entity.dart';
import 'package:inbox_iq/features/inbox/presentation/widgets/email_card.dart';
import 'package:inbox_iq/features/inbox/presentation/widgets/filter_chip_item.dart';

class InboxViewBody extends StatefulWidget {
  const InboxViewBody({super.key});

  @override
  State<InboxViewBody> createState() => _InboxViewBodyState();
}

class _InboxViewBodyState extends State<InboxViewBody> {
  String selectedFilter = 'All';
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> filters = [
    {'label': 'All', 'count': 8},
    {'label': 'Urgent', 'count': null},
    {'label': 'Action Required', 'count': null},
    {'label': 'FYI', 'count': null},
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<EmailEntity> get filteredEmails {
    switch (selectedFilter) {
      case 'Urgent':
        return mockEmails
            .where((e) => e.priority == EmailPriority.urgent)
            .toList();
      case 'Action Required':
        return mockEmails
            .where((e) => e.priority == EmailPriority.action)
            .toList();
      case 'FYI':
        return mockEmails
            .where((e) => e.priority == EmailPriority.fyi)
            .toList();
      default:
        return mockEmails;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
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

          // Filter Chips (Horizontal Scroll)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: _getHorizontalPadding(context),
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return FilterChipWidget(
                    label: filter['label'],
                    count: filter['count'],
                    isSelected: selectedFilter == filter['label'],
                    onTap: () {
                      setState(() {
                        selectedFilter = filter['label'];
                      });
                    },
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: AppConstants.spacing16)),

          // Email List
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: _getHorizontalPadding(context),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final emails = filteredEmails;
                if (index >= emails.length) return null;

                final email = emails[index];
                return EmailCard(
                  email: email,
                  onTap: () {
                    // TODO: Navigate to email detail
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Opened: ${email.subject}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                );
              }, childCount: filteredEmails.length),
            ),
          ),

          // Bottom spacing
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
