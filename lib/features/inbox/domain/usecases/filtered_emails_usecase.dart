import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';
import 'package:inbox_iq/features/inbox/domain/repos/inbox_repostry.dart';

class GetFilteredEmailsUseCase {
  final InboxRepository repository;

  GetFilteredEmailsUseCase(this.repository);

  Future<Either<Failure, List<EmailEntity>>> call(String filter) async {
    return await repository.getFilteredEmails(filter);
  }
}
