import 'package:equatable/equatable.dart';

class EmailStatistics extends Equatable {
  final int urgent;
  final int actionRequired;
  final int fyi;
  final int read;

  const EmailStatistics({
    required this.urgent,
    required this.actionRequired,
    required this.fyi,
    required this.read,
  });

  int get unread => urgent + actionRequired + fyi - read;

  @override
  List<Object?> get props => [urgent, actionRequired, fyi, read];
}
