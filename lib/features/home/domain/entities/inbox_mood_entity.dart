import 'package:equatable/equatable.dart';
import 'package:inbox_iq/features/home/domain/entities/mood_status_enum.dart';

class InboxMood extends Equatable {
  final MoodStatus status;
  final String description;
  final double score;

  const InboxMood({
    required this.status,
    required this.description,
    required this.score,
  });

  @override
  List<Object?> get props => [status, description, score];
}
