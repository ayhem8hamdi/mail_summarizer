import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/features/inbox/data/email_entity.dart';

class PriorityBadge extends StatelessWidget {
  final EmailPriority priority;

  const PriorityBadge({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    if (priority == EmailPriority.normal) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getBadgeColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        _getBadgeText(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _getBadgeColor(),
        ),
      ),
    );
  }

  Color _getBadgeColor() {
    switch (priority) {
      case EmailPriority.urgent:
        return AppColors.kUrgentRed;
      case EmailPriority.action:
        return AppColors.kNeutralYellow;
      case EmailPriority.fyi:
        return AppColors.kPositiveGreen;
      case EmailPriority.normal:
        return Colors.grey;
    }
  }

  String _getBadgeText() {
    switch (priority) {
      case EmailPriority.urgent:
        return 'URGENT';
      case EmailPriority.action:
        return 'ACTION';
      case EmailPriority.fyi:
        return 'FYI';
      case EmailPriority.normal:
        return '';
    }
  }
}
