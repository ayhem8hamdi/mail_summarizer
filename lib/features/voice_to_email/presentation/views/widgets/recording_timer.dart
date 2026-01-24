import 'package:flutter/material.dart';

class RecordingTimer extends StatelessWidget {
  final int seconds;
  final bool isProcessing;

  const RecordingTimer({
    super.key,
    required this.seconds,
    required this.isProcessing,
  });

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isProcessing)
          Text(
            _formatDuration(seconds),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        if (!isProcessing) const SizedBox(height: 8),
        Text(
          isProcessing ? 'Generating your email...' : 'Recording your reply...',
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8)),
        ),
      ],
    );
  }
}
