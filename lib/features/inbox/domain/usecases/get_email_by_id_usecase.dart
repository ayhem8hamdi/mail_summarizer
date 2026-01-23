import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';
import 'package:inbox_iq/features/inbox/domain/repos/inbox_repostry.dart';

class GetEmailByIdUseCase {
  final InboxRepository repository;

  GetEmailByIdUseCase(this.repository);

  Future<Either<Failure, EmailEntity>> call(String emailId) async {
    return await repository.getEmailById(emailId);
  }
}
