import 'package:hive/hive.dart';
import '../models/todo_model.dart';

class TodoRepository {
  final Box<TodoModel> _todoBox;

  TodoRepository(this._todoBox);

  Future<List<TodoModel>> getTodos() async {
    return _todoBox.values.toList();
  }

  Future<void> addTodo(TodoModel todo) async {
    await _todoBox.add(todo);
  }

  Future<void> editTodo(String id, TodoModel updatedTodo) async {
    final index = _todoBox.values.toList().indexWhere((todo) => todo.id == id);
    if (index != -1) {
      await _todoBox.putAt(index, updatedTodo);
    }
  }

  Future<void> deleteTodo(String id) async {
    final index = _todoBox.values.toList().indexWhere((todo) => todo.id == id);
    if (index != -1) {
      await _todoBox.deleteAt(index);
    }
  }

  Future<void> toggleTodoCompletion(String id) async {
    final index = _todoBox.values.toList().indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = _todoBox.getAt(index);
      if (todo != null) {
        final updatedTodo = TodoModel(
          id: todo.id,
          title: todo.title,
          description: todo.description,
          date: todo.date,
          isCompleted: !todo.isCompleted,
        );
        await _todoBox.putAt(index, updatedTodo);
      }
    }
  }
} 