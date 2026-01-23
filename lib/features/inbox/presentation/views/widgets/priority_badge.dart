import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';

class PriorityBadge extends StatelessWidget {
  final EmailPriority priority;

  const PriorityBadge({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
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
      case EmailPriority.normal:
        return const Color(0xFFFF9500); // Orange color
      case EmailPriority.fyi:
        return AppColors.kPositiveGreen;
    }
  }

  String _getBadgeText() {
    switch (priority) {
      case EmailPriority.urgent:
        return 'URGENT';
      case EmailPriority.normal:
        return 'NORMAL';
      case EmailPriority.fyi:
        return 'FYI';
    }
  }
}
