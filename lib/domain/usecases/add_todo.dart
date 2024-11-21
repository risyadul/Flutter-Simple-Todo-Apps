import '../../data/repositories/todo_repository.dart';
import '../../data/models/todo_model.dart';

class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  void call(TodoModel todo) {
    repository.addTodo(todo);
  }
} 