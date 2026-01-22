import 'package:inbox_iq/features/home/data/models/email_stats_model.dart';
import 'package:inbox_iq/features/home/data/models/inbox_mood_model.dart';
import 'package:inbox_iq/features/home/data/models/quick_actions_model.dart';
import 'package:inbox_iq/features/home/domain/entities/dailysummary_entity.dart';

class DailySummaryModel extends DailySummary {
  const DailySummaryModel({
    required super.date,
    required super.totalEmails,
    required super.statistics,
    required super.mood,
    required super.summary,
    required super.quickActions,
  });

  factory DailySummaryModel.fromJson(Map<String, dynamic> json) {
    return DailySummaryModel(
      date: json['date'] as String,
      totalEmails: json['totalEmails'] as int,
      statistics: EmailStatisticsModel.fromJson(
        json['statistics'] as Map<String, dynamic>,
      ),
      mood: InboxMoodModel.fromJson(json['mood'] as Map<String, dynamic>),
      summary: json['summary'] as String,
      quickActions: (json['quickActions'] as List<dynamic>)
          .map((e) => QuickActionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'totalEmails': totalEmails,
      'statistics': (statistics as EmailStatisticsModel).toJson(),
      'mood': (mood as InboxMoodModel).toJson(),
      'summary': summary,
      'quickActions': quickActions
          .map((e) => (e as QuickActionModel).toJson())
          .toList(),
    };
  }
}
