import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/voice_to_email/domain/entities/voice_to_email_response_entity.dart';

abstract class VoiceEmailRepository {
  /// Send audio file to N8N workflow and get generated email draft
  ///
  /// Parameters:
  /// - [audioFile]: The recorded audio file (mp3, wav, etc.)
  /// - [userId]: The user ID
  /// - [timestamp]: The timestamp of the recording
  ///
  /// Returns:
  /// - [Right(VoiceEmailResponseEntity)]: On success
  /// - [Left(Failure)]: On error
  Future<Either<Failure, VoiceEmailResponseEntity>> generateEmailFromVoice({
    required dynamic audioFile, // Changed from File to dynamic
    required String userId,
    required DateTime timestamp,
  });

  /// Send the final edited email
  ///
  /// Parameters:
  /// - [to]: Recipient email address
  /// - [subject]: Email subject
  /// - [body]: Email body content
  /// - [userId]: The user ID
  ///
  /// Returns:
  /// - [Right(bool)]: True on success
  /// - [Left(Failure)]: On error
  Future<Either<Failure, bool>> sendEmail({
    required String to,
    required String subject,
    required String body,
    required String userId,
  });
}
