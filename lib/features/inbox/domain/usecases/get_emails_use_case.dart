// lib/features/inbox/domain/usecases/get_emails_use_case.dart
import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';
import 'package:inbox_iq/features/inbox/domain/repos/inbox_repostry.dart';

class GetEmailsUseCase {
  final InboxRepository repository;

  GetEmailsUseCase(this.repository);

  Future<Either<Failure, List<EmailEntity>>> call({bool forceRefresh = false}) {
    return repository.getEmails(forceRefresh: forceRefresh);
  }
}
