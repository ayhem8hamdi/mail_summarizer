import 'package:inbox_iq/features/home/domain/entities/inbox_mood_entity.dart';
import 'package:inbox_iq/features/home/domain/entities/mood_status_enum.dart';

class InboxMoodModel extends InboxMood {
  const InboxMoodModel({
    required super.status,
    required super.description,
    required super.score,
  });

  factory InboxMoodModel.fromJson(Map<String, dynamic> json) {
    return InboxMoodModel(
      status: MoodStatus.fromString(json['status'] as String),
      description: json['description'] as String,
      score: (json['score'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status.label, 'description': description, 'score': score};
  }
}
