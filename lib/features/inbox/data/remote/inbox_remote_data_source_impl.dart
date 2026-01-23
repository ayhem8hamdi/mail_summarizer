import 'package:dio/dio.dart';
import 'package:inbox_iq/core/failure/exceptions.dart';
import 'package:inbox_iq/features/inbox/data/models/email_model.dart';
import 'package:inbox_iq/features/inbox/data/remote/inbox_remote_data_source.dart';

class InboxRemoteDataSourceImpl implements InboxRemoteDataSource {
  final Dio dio;
  final String webhookUrl;

  InboxRemoteDataSourceImpl({required this.dio, required this.webhookUrl});

  @override
  Future<List<EmailModel>> getEmails() async {
    try {
      final response = await dio.get(webhookUrl);

      if (response.statusCode == 200) {
        final data = response.data;

        // Handle both direct array and wrapped {"emails": [...]} format
        final List<dynamic> emailsJson;
        if (data is List) {
          emailsJson = data;
        } else if (data is Map<String, dynamic> && data.containsKey('emails')) {
          emailsJson = data['emails'] as List<dynamic>;
        } else {
          throw ServerException(
            message: 'Invalid response format',
            details: 'Expected array or object with "emails" key',
          );
        }

        return emailsJson
            .map((json) => EmailModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          message: 'Failed to fetch emails',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    } catch (e) {
      throw ServerException(
        message: 'Unexpected error occurred',
        details: e.toString(),
      );
    }
  }

  @override
  Future<EmailModel> getEmailById(String emailId) async {
    try {
      // For now, fetch all and filter (you can create a dedicated endpoint later)
      final emails = await getEmails();
      final email = emails.firstWhere(
        (e) => e.id == emailId,
        orElse: () =>
            throw ServerException(message: 'Email not found', statusCode: 404),
      );
      return email;
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        message: 'Failed to fetch email',
        details: e.toString(),
      );
    }
  }
}
