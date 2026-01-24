import 'dart:io';
import 'dart:typed_data';
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
    required dynamic audioFile, // Changed from File to dynamic
    required String userId,
    required DateTime timestamp,
  }) async {
    try {
      FormData formData;

      if (kIsWeb) {
        // For web platform - audioFile is WebFile
        print('🌐 Preparing web audio upload...');

        // Get bytes from WebFile
        final bytes = await audioFile.readAsBytes() as Uint8List;
        final filename = audioFile.filename ?? 'voice_recording.wav';

        print('📊 Audio bytes length: ${bytes.length}');

        formData = FormData.fromMap({
          'audioFile': MultipartFile.fromBytes(
            bytes,
            filename: filename,
            contentType: MediaType('audio', 'wav'),
          ),
          'userId': userId,
          'timestamp': timestamp.toIso8601String(),
        });
      } else {
        // For mobile platforms - audioFile is File
        print('📱 Preparing mobile audio upload...');

        final file = audioFile as File;

        // Get the file name
        final fileName = file.path.split('/').last;
        print('📁 File: $fileName');

        // Verify file exists
        if (!await file.exists()) {
          throw ServerException(
            message: 'Audio file not found',
            details: 'File does not exist at path: ${file.path}',
          );
        }

        final fileSize = await file.length();
        print('📊 File size: ${fileSize / 1024} KB');

        formData = FormData.fromMap({
          'audioFile': await MultipartFile.fromFile(
            file.path,
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
