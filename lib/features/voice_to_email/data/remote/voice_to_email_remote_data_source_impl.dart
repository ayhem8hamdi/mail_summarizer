import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http_parser/http_parser.dart';
import 'package:inbox_iq/core/failure/exceptions.dart';
import 'package:inbox_iq/features/voice_to_email/data/models/email_draft_model.dart';
import 'package:inbox_iq/features/voice_to_email/data/remote/voice_to_email_remote_data_source.dart';

class VoiceEmailRemoteDataSourceImpl implements VoiceEmailRemoteDataSource {
  final Dio dio;
  final String webhookUrl;
  final String sendEmailWebhookUrl;

  VoiceEmailRemoteDataSourceImpl({
    required this.dio,
    required this.webhookUrl,
    required this.sendEmailWebhookUrl,
  });

  @override
  Future<VoiceEmailResponseModel> generateEmailFromVoice({
    required File audioFile,
    required String userId,
    required DateTime timestamp,
  }) async {
    try {
      FormData formData;

      if (kIsWeb) {
        // For web platform
        print('🌐 Preparing web audio upload...');

        // Read audio file as bytes
        final bytes = await audioFile.readAsBytes();
        print('📊 Audio bytes length: ${bytes.length}');

        formData = FormData.fromMap({
          'audioFile': MultipartFile.fromBytes(
            bytes,
            filename: 'voice_recording.wav',
            contentType: MediaType('audio', 'wav'),
          ),
          'userId': userId,
          'timestamp': timestamp.toIso8601String(),
        });
      } else {
        // For mobile platforms (Android/iOS)
        print('📱 Preparing mobile audio upload...');

        // Get the file name
        final fileName = audioFile.path.split('/').last;
        print('📁 File: $fileName');

        // Verify file exists
        if (!await audioFile.exists()) {
          throw ServerException(
            message: 'Audio file not found',
            details: 'File does not exist at path: ${audioFile.path}',
          );
        }

        final fileSize = await audioFile.length();
        print('📊 File size: ${fileSize / 1024} KB');

        formData = FormData.fromMap({
          'audioFile': await MultipartFile.fromFile(
            audioFile.path,
            filename: fileName,
          ),
          'userId': userId,
          'timestamp': timestamp.toIso8601String(),
        });
      }

      print('🚀 Sending request to: $webhookUrl');

      // Make the request
      final response = await dio.post(
        webhookUrl,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      print('✅ Response status: ${response.statusCode}');
      print('📦 Response data: ${response.data}');

      if (response.statusCode == 200) {
        return VoiceEmailResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: 'Failed to generate email from voice',
          statusCode: response.statusCode,
          details: response.data.toString(),
        );
      }
    } on DioException catch (e) {
      print('❌ Dio error: ${e.type}');
      print('❌ Error message: ${e.message}');
      print('❌ Response: ${e.response?.data}');

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ServerException(message: 'Request timeout', statusCode: 408);
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(message: 'No internet connection');
      } else {
        throw ServerException(
          message: e.message ?? 'Unknown error occurred',
          statusCode: e.response?.statusCode,
          details: e.response?.data.toString(),
        );
      }
    } catch (e) {
      print('❌ Unexpected error: $e');
      throw ServerException(
        message: 'Unexpected error occurred',
        details: e.toString(),
      );
    }
  }

  @override
  Future<bool> sendEmail({
    required String to,
    required String subject,
    required String body,
    required String userId,
  }) async {
    try {
      print('📧 Sending email to: $to');

      final response = await dio.post(
        sendEmailWebhookUrl,
        data: {
          'to': to,
          'subject': subject,
          'body': body,
          'userId': userId,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      print('✅ Send email response: ${response.statusCode}');

      if (response.statusCode == 200) {
        return response.data['success'] ?? true;
      } else {
        throw ServerException(
          message: 'Failed to send email',
          statusCode: response.statusCode,
          details: response.data.toString(),
        );
      }
    } on DioException catch (e) {
      print('❌ Send email error: ${e.message}');

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ServerException(message: 'Request timeout', statusCode: 408);
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(message: 'No internet connection');
      } else {
        throw ServerException(
          message: e.message ?? 'Unknown error occurred',
          statusCode: e.response?.statusCode,
          details: e.response?.data.toString(),
        );
      }
    } catch (e) {
      print('❌ Unexpected send error: $e');
      throw ServerException(
        message: 'Unexpected error occurred',
        details: e.toString(),
      );
    }
  }
}
