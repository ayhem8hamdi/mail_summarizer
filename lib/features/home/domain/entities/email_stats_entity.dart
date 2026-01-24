// lib/features/home/domain/entities/email_stats_entity.dart
import 'package:equatable/equatable.dart';

class EmailStatistics extends Equatable {
  final int urgent;
  final int normal;
  final int fyi;
  final int read;

  const EmailStatistics({
    required this.urgent,
    required this.normal,
    required this.fyi,
    required this.read,
  });

  int get unread => urgent + normal + fyi - read;

  @override
  List<Object?> get props => [urgent, normal, fyi, read];
}
