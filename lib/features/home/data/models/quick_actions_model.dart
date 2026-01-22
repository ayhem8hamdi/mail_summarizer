import 'package:inbox_iq/features/home/domain/entities/quick_action_entity.dart';

class QuickActionModel extends QuickAction {
  const QuickActionModel({required super.task, required super.completed});

  factory QuickActionModel.fromJson(Map<String, dynamic> json) {
    return QuickActionModel(
      task: json['task'] as String,
      completed: json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'task': task, 'completed': completed};
  }
}
