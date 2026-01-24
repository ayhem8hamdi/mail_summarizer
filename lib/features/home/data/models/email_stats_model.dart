// lib/features/home/data/models/email_stats_model.dart
import 'package:inbox_iq/features/home/domain/entities/email_stats_entity.dart';

class EmailStatisticsModel extends EmailStatistics {
  const EmailStatisticsModel({
    required super.urgent,
    required super.normal,
    required super.fyi,
    required super.read,
  });

  factory EmailStatisticsModel.fromJson(Map<String, dynamic> json) {
    return EmailStatisticsModel(
      urgent: json['urgent'] as int,
      normal: json['normal'] as int,
      fyi: json['fyi'] as int,
      read: json['read'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'urgent': urgent, 'normal': normal, 'fyi': fyi, 'read': read};
  }
}
