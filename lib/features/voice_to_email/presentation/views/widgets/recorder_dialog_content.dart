import 'package:flutter/material.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/widgets/audio_waves_visulasition.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/widgets/microphone_animation.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/widgets/recording_action_buttons.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/widgets/recording_header.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/widgets/recording_timer.dart';


class RecordingDialogContent extends StatelessWidget {
  final int recordingSeconds;
  final bool isProcessing;
  final VoidCallback onCancel;
  final VoidCallback onStopAndGenerate;

  const RecordingDialogContent({
    super.key,
    required this.recordingSeconds,
    required this.isProcessing,
    required this.onCancel,
    required this.onStopAndGenerate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: const Color(0xFF2563EB),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RecordingHeader(onClose: isProcessing ? null : onCancel),
          const SizedBox(height: 20),
          const AudioWaveVisualization(),
          const SizedBox(height: 40),
          const MicrophoneAnimation(),
          const SizedBox(height: 40),
          RecordingTimer(
            seconds: recordingSeconds,
            isProcessing: isProcessing,
          ),
          const SizedBox(height: 40),
          RecordingActionButtons(
            onCancel: onCancel,
            onStopAndGenerate: onStopAndGenerate,
            isProcessing: isProcessing,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}