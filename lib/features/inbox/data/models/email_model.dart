import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';

class EmailModel extends EmailEntity {
  const EmailModel({
    required super.id,
    required super.senderName,
    required super.senderEmail,
    required super.subject,
    required super.snippet,
    required super.classification,
    required super.priority,
    required super.keyDetails,
    required super.deadline,
    required super.requiresAction,
    required super.reason,
    required super.timestamp,
    required super.hasAttachment,
    required super.isRead,
    required super.isStarred,
    required super.isArchived,
  });

  // From JSON
  factory EmailModel.fromJson(Map<String, dynamic> json) {
    return EmailModel(
      id: json['id'] ?? '',
      senderName: json['senderName'] ?? 'Unknown',
      senderEmail: json['senderEmail'] ?? '',
      subject: json['subject'] ?? 'No Subject',
      snippet: json['snippet'] ?? '',
      classification: json['classification'] ?? 'normal',
      priority: _parsePriority(json['priority']),
      keyDetails: json['keyDetails'] ?? '',
      deadline: json['deadline'] ?? 'none',
      requiresAction: json['requiresAction'] ?? false,
      reason: json['reason'] ?? '',
      timestamp: DateTime.parse(
        json['timestamp'] ?? DateTime.now().toIso8601String(),
      ),
      hasAttachment: json['hasAttachment'] ?? false,
      isRead: json['isRead'] ?? false,
      isStarred: json['isStarred'] ?? false,
      isArchived: json['isArchived'] ?? false,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderName': senderName,
      'senderEmail': senderEmail,
      'subject': subject,
      'snippet': snippet,
      'classification': classification,
      'priority': priority.name.toUpperCase(),
      'keyDetails': keyDetails,
      'deadline': deadline,
      'requiresAction': requiresAction,
      'reason': reason,
      'timestamp': timestamp.toIso8601String(),
      'hasAttachment': hasAttachment,
      'isRead': isRead,
      'isStarred': isStarred,
      'isArchived': isArchived,
    };
  }

  // Parse priority from string
  static EmailPriority _parsePriority(String? priority) {
    switch (priority?.toUpperCase()) {
      case 'URGENT':
        return EmailPriority.urgent;
      case 'ACTION':
      case 'ACTION_REQUIRED':
        return EmailPriority.action;
      case 'FYI':
        return EmailPriority.fyi;
      default:
        return EmailPriority.normal;
    }
  }

  // Copy with method for updates
  EmailModel copyWith({
    String? id,
    String? senderName,
    String? senderEmail,
    String? subject,
    String? snippet,
    String? classification,
    EmailPriority? priority,
    String? keyDetails,
    String? deadline,
    bool? requiresAction,
    String? reason,
    DateTime? timestamp,
    bool? hasAttachment,
    bool? isRead,
    bool? isStarred,
    bool? isArchived,
  }) {
    return EmailModel(
      id: id ?? this.id,
      senderName: senderName ?? this.senderName,
      senderEmail: senderEmail ?? this.senderEmail,
      subject: subject ?? this.subject,
      snippet: snippet ?? this.snippet,
      classification: classification ?? this.classification,
      priority: priority ?? this.priority,
      keyDetails: keyDetails ?? this.keyDetails,
      deadline: deadline ?? this.deadline,
      requiresAction: requiresAction ?? this.requiresAction,
      reason: reason ?? this.reason,
      timestamp: timestamp ?? this.timestamp,
      hasAttachment: hasAttachment ?? this.hasAttachment,
      isRead: isRead ?? this.isRead,
      isStarred: isStarred ?? this.isStarred,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}
