import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';

abstract class InboxRepository {
  /// Fetch all emails from the API
  Future<Either<Failure, List<EmailEntity>>> getEmails();

  /// Fetch emails by filter (urgent, action, fyi)
  Future<Either<Failure, List<EmailEntity>>> getFilteredEmails(String filter);

  /// Get single email by ID
  Future<Either<Failure, EmailEntity>> getEmailById(String emailId);

  /// Mark email as read
  Future<Either<Failure, bool>> markAsRead(String emailId);
}
