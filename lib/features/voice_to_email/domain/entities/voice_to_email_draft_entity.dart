import 'package:equatable/equatable.dart';

class VoiceEmailDraftEntity extends Equatable {
  final String to;
  final String recipientName;
  final String subject;
  final String body;
  final String greeting;
  final String closing;
  final String preview;
  final String tone;
  final String action;
  final List<String> keyPoints;
  final DateTime generatedAt;
  final String draftId;
  final bool isEdited;
  final bool isSent;
  final bool canEdit;

  const VoiceEmailDraftEntity({
    required this.to,
    required this.recipientName,
    required this.subject,
    required this.body,
    required this.greeting,
    required this.closing,
    required this.preview,
    required this.tone,
    required this.action,
    required this.keyPoints,
    required this.generatedAt,
    required this.draftId,
    required this.isEdited,
    required this.isSent,
    required this.canEdit,
  });

  @override
  List<Object?> get props => [
    to,
    recipientName,
    subject,
    body,
    greeting,
    closing,
    preview,
    tone,
    action,
    keyPoints,
    generatedAt,
    draftId,
    isEdited,
    isSent,
    canEdit,
  ];

  VoiceEmailDraftEntity copyWith({
    String? to,
    String? recipientName,
    String? subject,
    String? body,
    String? greeting,
    String? closing,
    String? preview,
    String? tone,
    String? action,
    List<String>? keyPoints,
    DateTime? generatedAt,
    String? draftId,
    bool? isEdited,
    bool? isSent,
    bool? canEdit,
  }) {
    return VoiceEmailDraftEntity(
      to: to ?? this.to,
      recipientName: recipientName ?? this.recipientName,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      greeting: greeting ?? this.greeting,
      closing: closing ?? this.closing,
      preview: preview ?? this.preview,
      tone: tone ?? this.tone,
      action: action ?? this.action,
      keyPoints: keyPoints ?? this.keyPoints,
      generatedAt: generatedAt ?? this.generatedAt,
      draftId: draftId ?? this.draftId,
      isEdited: isEdited ?? this.isEdited,
      isSent: isSent ?? this.isSent,
      canEdit: canEdit ?? this.canEdit,
    );
  }
}
