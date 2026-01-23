import 'package:flutter/material.dart';
import 'package:inbox_iq/features/inbox/data/email_details_entity.dart';
import 'package:inbox_iq/features/inbox/presentation/widgets/sender_avatar.dart';
import 'package:inbox_iq/features/inbox/presentation/widgets/priority_badge.dart';

class EmailDetailHeader extends StatelessWidget {
  final EmailDetailEntity email;

  const EmailDetailHeader({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sender Info Row
          Row(
            children: [
              // Avatar
              SenderAvatar(
                initial: email.senderInitial ?? email.sender[0],
                size: 48,
              ),

              const SizedBox(width: 12),

              // Sender Name & Email
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      email.sender,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      email.senderEmail,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Time
              Text(
                email.time,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Subject
          Text(
            email.subject,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
              height: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          // Priority Badge
          PriorityBadge(priority: email.priority),
        ],
      ),
    );
  }
}
