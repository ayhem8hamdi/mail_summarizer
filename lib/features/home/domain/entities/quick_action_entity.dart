import 'package:equatable/equatable.dart';

class QuickAction extends Equatable {
  final String task;
  final bool completed;

  const QuickAction({required this.task, required this.completed});

  QuickAction copyWith({String? task, bool? completed}) {
    return QuickAction(
      task: task ?? this.task,
      completed: completed ?? this.completed,
    );
  }

  @override
  List<Object?> get props => [task, completed];
}
