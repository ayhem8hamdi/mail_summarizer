// lib/features/voice_email/domain/usecases/send_email_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/voice_to_email/domain/repo/voice_to_email_repo.dart';

class SendEmailUseCase {
  final VoiceEmailRepository repository;

  SendEmailUseCase(this.repository);

  Future<Either<Failure, bool>> call({
    required String to,
    required String subject,
    required String body,
    required String userId,
  }) async {
    return await repository.sendEmail(
      to: to,
      subject: subject,
      body: body,
      userId: userId,
    );
  }
}
