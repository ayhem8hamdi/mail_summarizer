import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/voice_to_email/domain/entities/voice_to_email_response_entity.dart';
import 'package:inbox_iq/features/voice_to_email/domain/repo/voice_to_email_repo.dart';

class GenerateEmailFromVoiceUseCase {
  final VoiceEmailRepository repository;

  GenerateEmailFromVoiceUseCase(this.repository);

  Future<Either<Failure, VoiceEmailResponseEntity>> call({
    required File audioFile,
    required String userId,
    required DateTime timestamp,
  }) async {
    return await repository.generateEmailFromVoice(
      audioFile: audioFile,
      userId: userId,
      timestamp: timestamp,
    );
  }
}
