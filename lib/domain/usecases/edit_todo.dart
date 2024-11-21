import '../../data/repositories/todo_repository.dart';
import '../../data/models/todo_model.dart';

class EditTodo {
  final TodoRepository repository;

  EditTodo(this.repository);

  void call(String id, TodoModel updatedTodo) {
    repository.editTodo(id, updatedTodo);
  }
} 