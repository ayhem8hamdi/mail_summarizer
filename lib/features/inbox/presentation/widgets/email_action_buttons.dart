import 'package:flutter/material.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';

class EmailActionButtons extends StatelessWidget {
  final VoidCallback onReply;
  final VoidCallback onVoiceReply;

  const EmailActionButtons({
    super.key,
    required this.onReply,
    required this.onVoiceReply,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Reply Button (Outlined)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: onReply,
              icon: const Icon(Icons.reply, size: 20),
              label: const Text(
                'Reply',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.kPrimaryBlue,
                side: BorderSide(
                  color: AppColors.kPrimaryBlue.withOpacity(0.3),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Record Voice Reply Button (Filled)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: onVoiceReply,
              icon: const Icon(Icons.mic, size: 20),
              label: const Text(
                'Record Voice Reply',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
