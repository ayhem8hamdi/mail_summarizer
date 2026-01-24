import 'package:inbox_iq/features/voice_to_email/data/models/email_draft_model.dart';

abstract class VoiceEmailRemoteDataSource {
  Future<VoiceEmailResponseModel> generateEmailFromVoice({
    required dynamic audioFile, // Changed from File to dynamic
    required String userId,
    required DateTime timestamp,
  });

  Future<bool> sendEmail({
    required String to,
    required String subject,
    required String body,
    required String userId,
  });
}
