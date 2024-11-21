import '../../data/repositories/todo_repository.dart';

class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  void call(String id) {
    repository.deleteTodo(id);
  }
} 