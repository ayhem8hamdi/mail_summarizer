import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/manager/voice_recorder_cubit/voice_recorder_cubit.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/manager/email_draft_cubit/email_draft_cubit.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/manager/voice_recorder_cubit/voice_recorder_states.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/manager/email_draft_cubit/email_draft_states.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/generated_response_dialog.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/views/widgets/recorder_dialog_content.dart';

class VoiceRecordingDialog extends StatefulWidget {
  final String userId;

  const VoiceRecordingDialog({super.key, required this.userId});

  @override
  State<VoiceRecordingDialog> createState() => _VoiceRecordingDialogState();
}

class _VoiceRecordingDialogState extends State<VoiceRecordingDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VoiceRecorderCubit>().startRecording();
    });
  }

  void _handleStopAndGenerate() {
    context.read<VoiceRecorderCubit>().stopRecording();
  }

  void _handleCancel() {
    context.read<VoiceRecorderCubit>().cancelRecording();
    Navigator.of(context).pop();
  }

  void _showGeneratedEmailDialog() {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const GeneratedResponseDialog(),
    );
  }

  void _showError(String message) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<VoiceRecorderCubit, VoiceRecorderState>(
          listener: (context, state) {
            if (state is VoiceRecorderSuccess) {
              context.read<EmailDraftCubit>().generateEmailFromVoice(
                audioFilePath: state.audioFilePath,
                userId: widget.userId,
              );
            } else if (state is VoiceRecorderError) {
              _showError(state.message);
            }
          },
        ),
        BlocListener<EmailDraftCubit, EmailDraftState>(
          listener: (context, state) {
            if (state is EmailDraftSuccess) {
              _showGeneratedEmailDialog();
            } else if (state is EmailDraftError) {
              _showError(state.message);
            }
          },
        ),
      ],
      child: BlocBuilder<VoiceRecorderCubit, VoiceRecorderState>(
        builder: (context, voiceState) {
          final recordingSeconds = voiceState is VoiceRecorderRecording
              ? voiceState.durationInSeconds
              : 0;

          final isProcessing = voiceState is VoiceRecorderProcessing;

          return Dialog(
            backgroundColor: Colors.transparent,
            child: RecordingDialogContent(
              recordingSeconds: recordingSeconds,
              isProcessing: isProcessing,
              onCancel: _handleCancel,
              onStopAndGenerate: _handleStopAndGenerate,
            ),
          );
        },
      ),
    );
  }
}
