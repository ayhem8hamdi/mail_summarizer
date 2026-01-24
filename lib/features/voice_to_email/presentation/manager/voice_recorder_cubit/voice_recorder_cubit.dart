import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/manager/voice_recorder_cubit/voice_recorder_states.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class VoiceRecorderCubit extends Cubit<VoiceRecorderState> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  Timer? _recordingTimer;
  int _recordingDuration = 0;
  String? _currentRecordingPath;

  VoiceRecorderCubit() : super(const VoiceRecorderInitial());

  Future<void> startRecording() async {
    try {
      // Check permissions (skip on web, browser handles it)
      if (!kIsWeb) {
        final hasPermission = await _checkPermission();
        if (!hasPermission) {
          emit(
            const VoiceRecorderError(
              message: 'Microphone permission required.',
            ),
          );
          return;
        }
      }

      if (!await _audioRecorder.hasPermission()) {
        emit(
          const VoiceRecorderError(
            message:
                'Microphone permission denied. Please allow microphone access in your browser.',
          ),
        );
        return;
      }

      print('🎤 Starting recording (Web: $kIsWeb)');

      // Create a dummy path for web (will be ignored by the package)
      // The actual recording will be stored as a blob
      if (kIsWeb) {
        _currentRecordingPath =
            'web_recording_${DateTime.now().millisecondsSinceEpoch}.wav';
      } else {
        final directory = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        _currentRecordingPath =
            '${directory.path}/voice_recording_$timestamp.m4a';
      }

      // Start recording with platform-specific config
      await _audioRecorder.start(
        RecordConfig(
          encoder: kIsWeb ? AudioEncoder.wav : AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
          numChannels: kIsWeb ? 1 : 2,
        ),
        path: _currentRecordingPath!,
      );

      _recordingDuration = 0;
      emit(const VoiceRecorderRecording(durationInSeconds: 0));

      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _recordingDuration++;
        emit(VoiceRecorderRecording(durationInSeconds: _recordingDuration));
      });
    } catch (e) {
      print('❌ Recording error: $e');
      emit(
        VoiceRecorderError(
          message: 'Failed to start recording: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> stopRecording() async {
    try {
      emit(const VoiceRecorderProcessing());

      _recordingTimer?.cancel();
      _recordingTimer = null;

      final path = await _audioRecorder.stop();

      if (path != null && path.isNotEmpty) {
        if (kIsWeb) {
          // On web, path is a blob URL or data URL
          print('✅ Web recording saved');
          print(
            '📊 Blob URL: ${path.substring(0, path.length > 50 ? 50 : path.length)}...',
          );
          print('⏱️ Duration: $_recordingDuration seconds');
        } else {
          // On mobile, check file
          final file = File(path);
          if (await file.exists()) {
            final fileSize = await file.length();
            print('✅ Recording saved: $path');
            print('📊 File size: ${fileSize / 1024} KB');
            print('⏱️ Duration: $_recordingDuration seconds');

            if (fileSize < 1000) {
              print('⚠️ WARNING: File size very small - audio might be empty!');
            }
          }
        }

        emit(
          VoiceRecorderSuccess(
            audioFilePath: path,
            totalDurationInSeconds: _recordingDuration,
          ),
        );
      } else {
        emit(const VoiceRecorderError(message: 'Failed to save recording'));
      }
    } catch (e) {
      print('❌ Stop recording error: $e');
      emit(
        VoiceRecorderError(
          message: 'Failed to stop recording: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> cancelRecording() async {
    try {
      _recordingTimer?.cancel();
      _recordingTimer = null;

      await _audioRecorder.stop();

      if (_currentRecordingPath != null && !kIsWeb) {
        final file = File(_currentRecordingPath!);
        if (await file.exists()) {
          await file.delete();
          print('🗑️ Deleted recording');
        }
      }

      _resetState();
      emit(const VoiceRecorderInitial());
    } catch (e) {
      print('❌ Cancel error: $e');
      _resetState();
      emit(const VoiceRecorderInitial());
    }
  }

  void reset() {
    _resetState();
    emit(const VoiceRecorderInitial());
  }

  void _resetState() {
    _recordingTimer?.cancel();
    _recordingTimer = null;
    _recordingDuration = 0;
    _currentRecordingPath = null;
  }

  Future<bool> _checkPermission() async {
    if (kIsWeb) return true; // Browser handles permissions

    final status = await Permission.microphone.status;
    print('🔐 Microphone permission: $status');

    if (status.isGranted) return true;

    if (status.isDenied) {
      final result = await Permission.microphone.request();
      print('🔐 Permission result: $result');
      return result.isGranted;
    }

    return false;
  }

  @override
  Future<void> close() {
    _recordingTimer?.cancel();
    _audioRecorder.dispose();
    return super.close();
  }
}
