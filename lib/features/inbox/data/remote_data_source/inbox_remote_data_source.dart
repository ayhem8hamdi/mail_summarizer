import 'package:inbox_iq/features/inbox/data/models/email_model.dart';

abstract class InboxRemoteDataSource {
  /// Fetch emails from n8n webhook
  Future<List<EmailModel>> getEmails();

  /// Get single email by ID (if needed in the future)
  Future<EmailModel> getEmailById(String emailId);
}
