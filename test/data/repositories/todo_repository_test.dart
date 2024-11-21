import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_test/data/models/todo_model.dart';
import 'package:flutter_todo_test/data/repositories/todo_repository.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';

void main() {
  group('TodoRepository', () {
    late Box<TodoModel> todoBox;
    late TodoRepository todoRepository;

    setUp(() async {
      // Inisialisasi Hive untuk testing
      await setUpTestHive();
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(TodoModelAdapter());
      }
      todoBox = await Hive.openBox<TodoModel>('todos');
      todoRepository = TodoRepository(todoBox);
    });

    tearDown(() async {
      await todoBox.close();
      await tearDownTestHive();
    });

    test('should add a todo', () async {
      final todo = TodoModel(
        id: '1',
        title: 'Test Todo',
        description: 'This is a test todo',
        date: DateTime.now(),
      );

      await todoRepository.addTodo(todo);

      expect(todoBox.values.length, 1);
      expect(todoBox.getAt(0)?.title, 'Test Todo');
    });

    test('should edit a todo', () async {
      final todo = TodoModel(
        id: '1',
        title: 'Test Todo',
        description: 'This is a test todo',
        date: DateTime.now(),
      );

      await todoRepository.addTodo(todo);

      final updatedTodo = TodoModel(
        id: '1',
        title: 'Updated Todo',
        description: 'This is an updated test todo',
        date: DateTime.now(),
      );

      await todoRepository.editTodo('1', updatedTodo);

      expect(todoBox.getAt(0)?.title, 'Updated Todo');
    });

    test('should delete a todo', () async {
      final todo = TodoModel(
        id: '1',
        title: 'Test Todo',
        description: 'This is a test todo',
        date: DateTime.now(),
      );

      await todoRepository.addTodo(todo);
      await todoRepository.deleteTodo('1');

      expect(todoBox.values.length, 0);
    });

    test('should toggle todo completion', () async {
      final todo = TodoModel(
        id: '1',
        title: 'Test Todo',
        description: 'This is a test todo',
        date: DateTime.now(),
        isCompleted: false,
      );

      await todoRepository.addTodo(todo);
      await todoRepository.toggleTodoCompletion('1');

      expect(todoBox.getAt(0)?.isCompleted, true);
    });
  });
} 