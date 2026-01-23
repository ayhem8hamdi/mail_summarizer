import 'package:flutter/material.dart';

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
      child: Row(
        children: [
          // Reply Button
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onReply,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF2563EB),
                side: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.reply, size: 20),
              label: const Text(
                'Reply',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Record Voice Reply Button
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: onVoiceReply,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.mic, size: 20),
              label: const Text(
                'Record Voice Reply',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
