import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../data/models/todo_model.dart';
import '../../data/repositories/todo_repository.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/edit_todo.dart';
import '../widgets/todo_card.dart';
import '../widgets/todo_tab_bar.dart';
import 'add_todo_page.dart'; // Import halaman baru

class TodoListPage extends StatefulWidget {
  final Box<TodoModel> todoBox;

  TodoListPage({required this.todoBox});

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> with SingleTickerProviderStateMixin {
  late final TodoRepository _repository;
  late final AddTodo _addTodo;
  late final EditTodo _editTodo;
  late final DeleteTodo _deleteTodo;
  late TabController _tabController;
  final List<DateTime> _dates = List.generate(38, (index) {
    return DateTime.now().subtract(Duration(days: 7 - index));
  });

  @override
  void initState() {
    super.initState();
    _repository = TodoRepository(widget.todoBox);
    _addTodo = AddTodo(_repository);
    _editTodo = EditTodo(_repository);
    _deleteTodo = DeleteTodo(_repository);
    _tabController = TabController(length: _dates.length, vsync: this, initialIndex: 7);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToAddTodoPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTodoPage(
          onSave: (newTodo) {
            _addTodo.call(newTodo);
            _moveToSelectedDateTab(newTodo.date);
            setState(() {});
          },
        ),
      ),
    );
  }

  void _navigateToEditTodoPage(TodoModel todo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTodoPage(
          existingTodo: todo,
          onSave: (updatedTodo) {
            _editTodo.call(todo.id, updatedTodo);
            _moveToSelectedDateTab(updatedTodo.date);
            setState(() {});
          },
        ),
      ),
    );
  }

  void _moveToSelectedDateTab(DateTime date) {
    final index = _dates.indexWhere((d) =>
        d.year == date.year && d.month == date.month && d.day == date.day);
    if (index != -1 && index != _tabController.index) {
      _tabController.animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _dates.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
          bottom: TodoTabBar(tabController: _tabController, dates: _dates),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _dates.map((date) {
            return FutureBuilder<List<TodoModel>>(
              future: _repository.getTodos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _buildEmptyState();
                } else {
                  final todos = snapshot.data!;
                  final filteredTodos = todos.where((todo) {
                    return todo.date.year == date.year &&
                           todo.date.month == date.month &&
                           todo.date.day == date.day;
                  }).toList();

                  if (filteredTodos.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.builder(
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = filteredTodos[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TodoCard(
                          title: todo.title,
                          description: todo.description,
                          isCompleted: todo.isCompleted,
                          onEdit: () {
                            _navigateToEditTodoPage(todo);
                          },
                          onDelete: () async {
                            _deleteTodo.call(todo.id);
                            setState(() {});
                          },
                          onToggleComplete: () async {
                            await _repository.toggleTodoCompletion(todo.id);
                            setState(() {});
                          },
                        ),
                      );
                    },
                  );
                }
              },
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToAddTodoPage,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: 100,
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Text(
            'No Todos Available',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
} 