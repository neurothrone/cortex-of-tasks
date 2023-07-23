import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/task_list.dart';

final taskListProvider =
    StateNotifierProvider<TaskListNotifier, List<TaskList>>(
  (ref) => TaskListNotifier(),
);

class TaskListNotifier extends StateNotifier<List<TaskList>> {
  TaskListNotifier() : super([]);

  void addTaskListNamed(String name) {
    final newTaskList = TaskList.newTaskList(name: name);
    state = [...state, newTaskList];
    _sortTaskLists();
  }

  void updateTaskLists(List<TaskList> taskLists) {
    state = taskLists;
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;

    // Create a copy of the current state
    final taskLists = List<TaskList>.from(state);

    final taskListToMove = taskLists.removeAt(oldIndex);
    taskLists.insert(newIndex, taskListToMove);

    for (int i = 0; i < taskLists.length; i++) {
      final modifiedTaskList = taskLists[i].copyWith(order: i);
      taskLists[i] = modifiedTaskList;
    }

    // Update state with new list
    updateTaskLists(taskLists);
  }

  void _sortTaskLists() {
    state.sort((a, b) => a.order.compareTo(b.order));
  }
}
