import 'package:uuid/uuid.dart';

import '../../task/domain/task.dart';

class TaskList {
  const TaskList._({
    required this.id,
    required this.name,
    this.order = 0,
    required this.tasks,
  });

  factory TaskList.newTaskList({
    required String name,
  }) {
    const uuid = Uuid();
    return TaskList._(
      id: uuid.v4(),
      name: name,
      order: 0,
      tasks: [],
    );
  }

  final String id;
  final String name;
  final int order;
  final List<Task> tasks;

  TaskList copyWith({
    String? id,
    String? name,
    int? order,
    List<Task>? tasks,
  }) =>
      TaskList._(
        id: id ?? this.id,
        name: name ?? this.name,
        order: order ?? this.order,
        tasks: tasks ?? this.tasks,
      );
}
