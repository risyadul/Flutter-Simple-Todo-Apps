import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/models/todo_model.dart';
import 'presentation/pages/todo_list_page.dart';

void main() async {
  // Inisialisasi Hive
  await Hive.initFlutter();
  // Registrasi adapter untuk TodoModel
  Hive.registerAdapter(TodoModelAdapter());
  // Buka kotak Hive untuk menyimpan TodoModel
  final todoBox = await Hive.openBox<TodoModel>('todos');
  // Jalankan aplikasi dengan kotak yang dibuka
  runApp(MyApp(todoBox: todoBox));
}

class MyApp extends StatelessWidget {
  final Box<TodoModel> todoBox;

  MyApp({required this.todoBox});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: TodoListPage(todoBox: todoBox), // Pastikan todoBox diteruskan ke TodoListPage
    );
  }
}