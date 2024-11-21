class Todo {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime date;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.date,
  });
} 