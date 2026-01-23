import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

enum EmailPriority { urgent, fyi, normal }

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

  /// Get formatted time for display (HH:mm if today, "Yesterday" if yesterday, DD/MM/YY otherwise)
  String get formattedTime {
    final now = DateTime.now();
    final emailDate = DateTime(timestamp.year, timestamp.month, timestamp.day);
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (emailDate == today) {
      // Today: Show HH:mm
      return DateFormat('HH:mm').format(timestamp);
    } else if (emailDate == yesterday) {
      // Yesterday
      return 'Yesterday';
    } else {
      // Older: Show DD/MM/YY
      return DateFormat('dd/MM/yy').format(timestamp);
    }
  }

  /// Get sender initial for avatar
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
