import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';
import 'package:inbox_iq/features/inbox/domain/repos/inbox_repostry.dart';

class GetEmailsUseCase {
  final InboxRepository repository;

  GetEmailsUseCase(this.repository);

  Future<Either<Failure, List<EmailEntity>>> call() async {
    return await repository.getEmails();
  }
}
