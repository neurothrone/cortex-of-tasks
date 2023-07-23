class Task {
  const Task({
    required this.description,
    this.isDone = false,
    this.order = 0,
  });

  final String description;
  final bool isDone;
  final int order;

  Task copyWith({
    required String description,
    required bool isDone,
    required int order,
  }) {
    return Task(
      description: description,
      isDone: isDone,
      order: order,
    );
  }
}
