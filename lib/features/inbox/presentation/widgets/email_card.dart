import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/features/inbox/data/email_entity.dart';
import 'package:inbox_iq/features/inbox/presentation/widgets/priority_badge.dart';

class EmailCard extends StatelessWidget {
  final EmailEntity email;
  final VoidCallback onTap;

  const EmailCard({super.key, required this.email, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: email.isRead
                ? const Color(0xFFE2E8F0)
                : AppColors.kPrimaryBlue.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Sender + Time + Unread Indicator
            Row(
              children: [
                // Priority colored dot
                if (email.priority != EmailPriority.normal)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(email.priority),
                      shape: BoxShape.circle,
                    ),
                  ),

                // Sender name
                Expanded(
                  child: Text(
                    email.sender,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: email.isRead
                          ? FontWeight.w500
                          : FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(width: 8),

                // Time
                Text(
                  email.time,
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF94A3B8),
                    fontWeight: email.isRead
                        ? FontWeight.w400
                        : FontWeight.w600,
                  ),
                ),

                const SizedBox(width: 8),

                // Unread blue dot
                if (!email.isRead)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.kPrimaryBlue,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 8),

            // Subject
            Text(
              email.subject,
              style: TextStyle(
                fontSize: 15,
                fontWeight: email.isRead ? FontWeight.w500 : FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 6),

            // Preview
            Text(
              email.preview,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // Footer: Priority Badge + Attachment
            Row(
              children: [
                // Priority badge
                PriorityBadge(priority: email.priority),

                const Spacer(),

                // Attachment indicator
                if (email.hasAttachment)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.attach_file,
                          size: 12,
                          color: Color(0xFF64748B),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Attachment',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(EmailPriority priority) {
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
}
