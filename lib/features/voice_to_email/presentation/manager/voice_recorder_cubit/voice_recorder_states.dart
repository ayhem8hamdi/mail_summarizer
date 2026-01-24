import 'package:equatable/equatable.dart';

abstract class VoiceRecorderState extends Equatable {
  const VoiceRecorderState();

  @override
  List<Object?> get props => [];
}

class VoiceRecorderInitial extends VoiceRecorderState {
  const VoiceRecorderInitial();
}

class VoiceRecorderRecording extends VoiceRecorderState {
  final int durationInSeconds;

  const VoiceRecorderRecording({required this.durationInSeconds});

  @override
  List<Object?> get props => [durationInSeconds];
}

class VoiceRecorderProcessing extends VoiceRecorderState {
  const VoiceRecorderProcessing();
}

class VoiceRecorderSuccess extends VoiceRecorderState {
  final String audioFilePath;
  final int totalDurationInSeconds;

  const VoiceRecorderSuccess({
    required this.audioFilePath,
    required this.totalDurationInSeconds,
  });

  @override
  List<Object?> get props => [audioFilePath, totalDurationInSeconds];
}

class VoiceRecorderError extends VoiceRecorderState {
  final String message;

  const VoiceRecorderError({required this.message});

  @override
  List<Object?> get props => [message];
}
