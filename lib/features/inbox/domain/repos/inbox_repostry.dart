// lib/features/inbox/domain/repos/inbox_repostry.dart
import 'package:dartz/dartz.dart';
import 'package:inbox_iq/core/failure/failure.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';

abstract class InboxRepository {
  /// Fetch all emails from the API
  ///
  /// [forceRefresh] - if true, bypass cache and fetch from remote API
  /// Returns cached data if available when forceRefresh is false
  Future<Either<Failure, List<EmailEntity>>> getEmails({
    bool forceRefresh = false,
  });

  /// Fetch emails by filter (urgent, normal, fyi, all)
  Future<Either<Failure, List<EmailEntity>>> getFilteredEmails(String filter);

  /// Get single email by ID
  Future<Either<Failure, EmailEntity>> getEmailById(String emailId);

  /// Mark email as read
  Future<Either<Failure, bool>> markAsRead(String emailId);
}
