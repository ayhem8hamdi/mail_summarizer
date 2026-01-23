import 'package:equatable/equatable.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';

abstract class InboxState extends Equatable {
  const InboxState();

  @override
  List<Object?> get props => [];
}

class InboxInitial extends InboxState {}

class InboxLoading extends InboxState {}

class InboxLoaded extends InboxState {
  final List<EmailEntity> emails;
  final String currentFilter;

  const InboxLoaded({required this.emails, this.currentFilter = 'All'});

  /// Get filtered emails based on current filter
  List<EmailEntity> get filteredEmails {
    switch (currentFilter.toLowerCase()) {
      case 'urgent':
        return emails.where((e) => e.priority == EmailPriority.urgent).toList();
      case 'fyi':
        return emails.where((e) => e.priority == EmailPriority.fyi).toList();
      case 'normal':
        return emails.where((e) => e.priority == EmailPriority.normal).toList();
      default:
        return emails;
    }
  }

  /// Get counts for filter chips
  int get totalCount => emails.length;
  int get urgentCount =>
      emails.where((e) => e.priority == EmailPriority.urgent).length;
  int get fyiCount =>
      emails.where((e) => e.priority == EmailPriority.fyi).length;
  int get normalCount =>
      emails.where((e) => e.priority == EmailPriority.normal).length;

  @override
  List<Object?> get props => [emails, currentFilter];
}

class InboxRefreshing extends InboxState {
  final List<EmailEntity> currentEmails;
  final String currentFilter;

  const InboxRefreshing({
    required this.currentEmails,
    required this.currentFilter,
  });

  @override
  List<Object?> get props => [currentEmails, currentFilter];
}

class InboxError extends InboxState {
  final String message;
  final String? details;

  const InboxError({required this.message, this.details});

  @override
  List<Object?> get props => [message, details];
}
