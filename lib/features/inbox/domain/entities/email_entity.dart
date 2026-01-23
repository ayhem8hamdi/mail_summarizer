import 'package:equatable/equatable.dart';

enum EmailPriority { urgent, action, fyi, normal }

class EmailEntity extends Equatable {
  final String id;
  final String senderName;
  final String senderEmail;
  final String subject;
  final String snippet;
  final String classification;
  final EmailPriority priority;
  final String keyDetails;
  final String deadline;
  final bool requiresAction;
  final String reason;
  final DateTime timestamp;
  final bool hasAttachment;
  final bool isRead;
  final bool isStarred;
  final bool isArchived;

  const EmailEntity({
    required this.id,
    required this.senderName,
    required this.senderEmail,
    required this.subject,
    required this.snippet,
    required this.classification,
    required this.priority,
    required this.keyDetails,
    required this.deadline,
    required this.requiresAction,
    required this.reason,
    required this.timestamp,
    required this.hasAttachment,
    required this.isRead,
    required this.isStarred,
    required this.isArchived,
  });

  // Get formatted time for display
  String get formattedTime {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  // Get sender initial for avatar
  String get senderInitial {
    return senderName.isNotEmpty ? senderName[0].toUpperCase() : '?';
  }

  @override
  List<Object?> get props => [
    id,
    senderName,
    senderEmail,
    subject,
    snippet,
    classification,
    priority,
    keyDetails,
    deadline,
    requiresAction,
    reason,
    timestamp,
    hasAttachment,
    isRead,
    isStarred,
    isArchived,
  ];
}
