// lib/features/voice_email/data/models/voice_email_draft_model.dart
import 'package:inbox_iq/features/voice_to_email/domain/entities/voice_to_email_draft_entity.dart';
import 'package:inbox_iq/features/voice_to_email/domain/entities/voice_to_email_processing_entity.dart';
import 'package:inbox_iq/features/voice_to_email/domain/entities/voice_to_email_response_entity.dart';

class VoiceEmailDraftModel extends VoiceEmailDraftEntity {
  const VoiceEmailDraftModel({
    required super.to,
    required super.recipientName,
    required super.subject,
    required super.body,
    required super.greeting,
    required super.closing,
    required super.preview,
    required super.tone,
    required super.action,
    required super.keyPoints,
    required super.generatedAt,
    required super.draftId,
    required super.isEdited,
    required super.isSent,
    required super.canEdit,
  });

  factory VoiceEmailDraftModel.fromJson(Map<String, dynamic> json) {
    return VoiceEmailDraftModel(
      to: json['to'] ?? '',
      recipientName: json['recipientName'] ?? '',
      subject: json['subject'] ?? '',
      body: json['body'] ?? '',
      greeting: json['greeting'] ?? '',
      closing: json['closing'] ?? '',
      preview: json['preview'] ?? '',
      tone: json['tone'] ?? '',
      action: json['action'] ?? '',
      keyPoints: List<String>.from(json['keyPoints'] ?? []),
      generatedAt: DateTime.parse(json['generatedAt']),
      draftId: json['draftId'] ?? '',
      isEdited: json['isEdited'] ?? false,
      isSent: json['isSent'] ?? false,
      canEdit: json['canEdit'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'to': to,
      'recipientName': recipientName,
      'subject': subject,
      'body': body,
      'greeting': greeting,
      'closing': closing,
      'preview': preview,
      'tone': tone,
      'action': action,
      'keyPoints': keyPoints,
      'generatedAt': generatedAt.toIso8601String(),
      'draftId': draftId,
      'isEdited': isEdited,
      'isSent': isSent,
      'canEdit': canEdit,
    };
  }
}

class VoiceEmailProcessingModel extends VoiceEmailProcessingEntity {
  const VoiceEmailProcessingModel({
    required super.originalCommand,
    required super.language,
    required super.userId,
    required super.processedAt,
  });

  factory VoiceEmailProcessingModel.fromJson(Map<String, dynamic> json) {
    return VoiceEmailProcessingModel(
      originalCommand: json['originalCommand'] ?? '',
      language: json['language'] ?? 'en',
      userId: json['userId'] ?? 'unknown',
      processedAt: DateTime.parse(json['processedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'originalCommand': originalCommand,
      'language': language,
      'userId': userId,
      'processedAt': processedAt.toIso8601String(),
    };
  }
}

class VoiceEmailResponseModel extends VoiceEmailResponseEntity {
  const VoiceEmailResponseModel({
    required super.success,
    required super.draft,
    required super.processing,
  });

  factory VoiceEmailResponseModel.fromJson(Map<String, dynamic> json) {
    return VoiceEmailResponseModel(
      success: json['success'] ?? false,
      draft: VoiceEmailDraftModel.fromJson(json['draft']),
      processing: VoiceEmailProcessingModel.fromJson(json['processing']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'draft': (draft as VoiceEmailDraftModel).toJson(),
      'processing': (processing as VoiceEmailProcessingModel).toJson(),
    };
  }
}
