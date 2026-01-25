import 'package:inbox_iq/features/inbox/data/models/email_model.dart';

abstract class InboxLocalDataSource {
  /// Get cached emails
  Future<List<EmailModel>> getCachedEmails();

  /// Cache emails
  Future<void> cacheEmails(List<EmailModel> emails);

  /// Clear cached emails
  Future<void> clearCache();

  /// Get single cached email by ID
  Future<EmailModel?> getCachedEmailById(String emailId);

  /// Check if cache exists and is valid
  Future<bool> hasCachedData();
}
