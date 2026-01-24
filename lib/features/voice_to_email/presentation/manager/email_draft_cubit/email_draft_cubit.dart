import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox_iq/core/DI/di.dart';
import 'package:inbox_iq/features/voice_to_email/domain/usecase/generate_email_from_voice_usecase.dart';
import 'package:inbox_iq/features/voice_to_email/domain/usecase/send_email_use_case.dart';
import 'package:inbox_iq/features/voice_to_email/presentation/manager/email_draft_cubit/email_draft_states.dart';

class EmailDraftCubit extends Cubit<EmailDraftState> {
  final GenerateEmailFromVoiceUseCase generateEmailFromVoiceUseCase;
  final SendEmailUseCase sendEmailUseCase;

  EmailDraftCubit({
    required this.generateEmailFromVoiceUseCase,
    required this.sendEmailUseCase,
  }) : super(const EmailDraftInitial());

  Future<void> generateEmailFromVoice({
    required String audioFilePath,
    required String userId,
  }) async {
    try {
      File audioFile;

      if (kIsWeb) {
        // For web: audioFilePath is a blob URL like "blob:http://localhost:8080/..."
        print('🌐 Processing web blob: $audioFilePath');

        // Use Dio to fetch the blob data
        final dio = sl<Dio>();
        final response = await dio.get<List<int>>(
          audioFilePath,
          options: Options(responseType: ResponseType.bytes),
        );

        if (response.statusCode == 200 && response.data != null) {
          final bytes = response.data!;
          print('📊 Downloaded ${bytes.length} bytes from blob');

          // Create a file object from bytes (web-compatible)
          audioFile = File.fromRawPath(Uint8List.fromList(bytes));
        } else {
          emit(
            const EmailDraftError(message: 'Failed to load audio recording'),
          );
          return;
        }
      } else {
        // For mobile: audioFilePath is a regular file path
        audioFile = File(audioFilePath);

        if (!await audioFile.exists()) {
          emit(const EmailDraftError(message: 'Audio file not found'));
          return;
        }
      }

      final result = await generateEmailFromVoiceUseCase(
        audioFile: audioFile,
        userId: userId,
        timestamp: DateTime.now(),
      );

      result.fold(
        (failure) {
          emit(EmailDraftError(message: failure.userMessage));
        },
        (response) {
          emit(EmailDraftSuccess(response: response));

          // Only delete file on mobile (web uses blob URLs)
          if (!kIsWeb) {
            _deleteAudioFile(audioFilePath);
          }
        },
      );
    } catch (e) {
      print('❌ Generate email error: $e');
      emit(
        EmailDraftError(message: 'Failed to process audio: ${e.toString()}'),
      );
    }
  }

  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
    required String userId,
  }) async {
    emit(const EmailDraftSending());

    final result = await sendEmailUseCase(
      to: to,
      subject: subject,
      body: body,
      userId: userId,
    );

    result.fold(
      (failure) {
        emit(EmailDraftSendFailed(message: failure.userMessage));
      },
      (success) {
        if (success) {
          emit(const EmailDraftSent());
        } else {
          emit(const EmailDraftSendFailed(message: 'Failed to send email'));
        }
      },
    );
  }

  Future<void> _deleteAudioFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Ignore deletion errors
      print('⚠️ Could not delete audio file: $e');
    }
  }

  void reset() {
    emit(const EmailDraftInitial());
  }
}
