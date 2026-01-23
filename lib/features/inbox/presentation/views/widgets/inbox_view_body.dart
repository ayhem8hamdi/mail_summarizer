import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inbox_iq/core/router/app_router.dart';
import 'package:inbox_iq/core/utils/constants.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';
import 'package:inbox_iq/features/inbox/presentation/manager/inbox_cubit/inbox_cubit.dart';
import 'package:inbox_iq/features/inbox/presentation/manager/inbox_cubit/inbox_cubit_states.dart';
import 'package:inbox_iq/features/inbox/presentation/views/widgets/email_card.dart';
import 'package:inbox_iq/features/inbox/presentation/views/widgets/filter_chip_item.dart';
import 'package:inbox_iq/features/inbox/presentation/views/widgets/inbox_error_widget.dart';

class InboxViewBody extends StatelessWidget {
  const InboxViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InboxCubit, InboxState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<InboxCubit>().refreshEmails();
          },
          child: SafeArea(
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
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

                if (state is InboxLoaded || state is InboxRefreshing)
                  _buildFilterChips(context, state),

                SliverToBoxAdapter(
                  child: SizedBox(height: AppConstants.spacing16),
                ),

                if (state is InboxLoading)
                  _buildLoadingState()
                else if (state is InboxError)
                  _buildErrorState(context, state)
                else if (state is InboxLoaded || state is InboxRefreshing)
                  _buildEmailList(context, state),

                SliverToBoxAdapter(
                  child: SizedBox(height: AppConstants.spacing24),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterChips(BuildContext context, InboxState state) {
    final cubit = context.read<InboxCubit>();

    final currentFilter = state is InboxLoaded
        ? state.currentFilter
        : (state as InboxRefreshing).currentFilter;

    final totalCount = state is InboxLoaded
        ? state.totalCount
        : (state as InboxRefreshing).currentEmails.length;

    final urgentCount = state is InboxLoaded
        ? state.urgentCount
        : (state as InboxRefreshing).currentEmails
              .where((e) => e.priority == EmailPriority.urgent)
              .length;

    final normalCount = state is InboxLoaded
        ? state.normalCount
        : (state as InboxRefreshing).currentEmails
              .where((e) => e.priority == EmailPriority.normal)
              .length;

    final fyiCount = state is InboxLoaded
        ? state.fyiCount
        : (state as InboxRefreshing).currentEmails
              .where((e) => e.priority == EmailPriority.fyi)
              .length;

    final filters = [
      {'label': 'All', 'count': totalCount},
      {'label': 'Urgent', 'count': urgentCount},
      {'label': 'Normal', 'count': normalCount},
      {'label': 'FYI', 'count': fyiCount},
    ];

    return SliverToBoxAdapter(
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
              label: filter['label'] as String,
              count: filter['count'] as int?,
              isSelected: currentFilter == filter['label'],
              onTap: () {
                cubit.changeFilter(filter['label'] as String);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmailList(BuildContext context, InboxState state) {
    final emails = state is InboxLoaded
        ? state.filteredEmails
        : (state as InboxRefreshing).currentEmails;

    if (emails.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.inbox_outlined, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'No emails found',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: _getHorizontalPadding(context)),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          if (index >= emails.length) return null;

          final email = emails[index];
          return EmailCard(
            email: email,
            onTap: () {
              // Pass the entire email object as JSON string
              context.pushNamed(
                AppRouter.inboxDetailsScreen,
                pathParameters: {'emailId': email.id},
                extra: email, // Pass the email object directly
              );
            },
          );
        }, childCount: emails.length),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const SliverFillRemaining(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorState(BuildContext context, InboxError state) {
    return SliverFillRemaining(
      child: InboxErrorWidget(
        message: state.message,
        onRetry: () {
          context.read<InboxCubit>().fetchEmails();
        },
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
