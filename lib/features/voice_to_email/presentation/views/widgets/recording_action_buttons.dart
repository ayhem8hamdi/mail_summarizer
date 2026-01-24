import 'package:flutter/material.dart';

class RecordingActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onStopAndGenerate;
  final bool isProcessing;

  const RecordingActionButtons({
    super.key,
    required this.onCancel,
    required this.onStopAndGenerate,
    required this.isProcessing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: isProcessing ? null : onCancel,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white, width: 2),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledForegroundColor: Colors.white.withOpacity(0.5),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: isProcessing ? null : onStopAndGenerate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF2563EB),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: isProcessing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF2563EB),
                      ),
                    )
                  : const Icon(Icons.auto_awesome, size: 20),
              label: Text(
                isProcessing ? 'Processing...' : 'Stop & Generate',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
