import 'package:inbox_iq/features/home/domain/entities/email_stats_entity.dart';

class EmailStatisticsModel extends EmailStatistics {
  const EmailStatisticsModel({
    required super.urgent,
    required super.actionRequired,
    required super.fyi,
    required super.read,
  });

  factory EmailStatisticsModel.fromJson(Map<String, dynamic> json) {
    return EmailStatisticsModel(
      urgent: json['urgent'] as int,
      actionRequired: json['actionRequired'] as int,
      fyi: json['fyi'] as int,
      read: json['read'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'urgent': urgent,
      'actionRequired': actionRequired,
      'fyi': fyi,
      'read': read,
    };
  }
}
