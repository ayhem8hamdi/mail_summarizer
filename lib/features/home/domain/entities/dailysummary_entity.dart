import 'package:equatable/equatable.dart';
import 'package:inbox_iq/features/home/domain/entities/email_stats_entity.dart';
import 'package:inbox_iq/features/home/domain/entities/inbox_mood_entity.dart';
import 'package:inbox_iq/features/home/domain/entities/quick_action_entity.dart';

class DailySummary extends Equatable {
  final String date;
  final int totalEmails;
  final EmailStatistics statistics;
  final InboxMood mood;
  final String summary;
  final List<QuickAction> quickActions;

  const DailySummary({
    required this.date,
    required this.totalEmails,
    required this.statistics,
    required this.mood,
    required this.summary,
    required this.quickActions,
  });

  @override
  List<Object?> get props => [
    date,
    totalEmails,
    statistics,
    mood,
    summary,
    quickActions,
  ];
}
