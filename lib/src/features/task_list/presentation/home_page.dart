import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/task_list_provider.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskLists = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task List App"),
      ),
      body: ReorderableListView.builder(
        itemCount: taskLists.length,
        onReorder: (oldIndex, newIndex) {
          ref.read(taskListProvider.notifier).onReorder(oldIndex, newIndex);
        },
        itemBuilder: (context, index) {
          return ListTile(
            key: Key(taskLists[index].id),
            title: Text(taskLists[index].name),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Add Task List"),
              content: TextField(
                controller: _textController,
              ),
              actions: [
                TextButton(
                  child: const Text("Add"),
                  onPressed: () {
                    ref
                        .read(taskListProvider.notifier)
                        .addTaskListNamed(_textController.text);

                    _textController.clear();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
