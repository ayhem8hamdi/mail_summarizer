import 'package:equatable/equatable.dart';

class VoiceEmailProcessingEntity extends Equatable {
  final String originalCommand;
  final String language;
  final String userId;
  final DateTime processedAt;

  const VoiceEmailProcessingEntity({
    required this.originalCommand,
    required this.language,
    required this.userId,
    required this.processedAt,
  });

  @override
  List<Object?> get props => [originalCommand, language, userId, processedAt];
}
