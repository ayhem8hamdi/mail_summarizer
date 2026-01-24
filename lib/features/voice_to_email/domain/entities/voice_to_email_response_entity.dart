import 'package:equatable/equatable.dart';
import 'package:inbox_iq/features/voice_to_email/domain/entities/voice_to_email_draft_entity.dart';
import 'package:inbox_iq/features/voice_to_email/domain/entities/voice_to_email_processing_entity.dart';

class VoiceEmailResponseEntity extends Equatable {
  final bool success;
  final VoiceEmailDraftEntity draft;
  final VoiceEmailProcessingEntity processing;

  const VoiceEmailResponseEntity({
    required this.success,
    required this.draft,
    required this.processing,
  });

  @override
  List<Object?> get props => [success, draft, processing];
}
