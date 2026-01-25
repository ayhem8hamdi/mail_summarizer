// lib/features/inbox/presentation/views/widgets/shimmer_email_card.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEmailCard extends StatelessWidget {
  const ShimmerEmailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Sender + Time
            Row(
              children: [
                // Priority dot
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),

                // Sender name
                Expanded(
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),

                const SizedBox(width: 60),

                // Time
                Container(
                  width: 60,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                const SizedBox(width: 8),

                // Unread dot
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Subject
            Container(
              width: double.infinity,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            const SizedBox(height: 6),

            // Snippet line 1
            Container(
              width: double.infinity,
              height: 13,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            const SizedBox(height: 4),

            // Snippet line 2
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 13,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            const SizedBox(height: 12),

            // Footer: Priority Badge
            Row(
              children: [
                Container(
                  width: 60,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
