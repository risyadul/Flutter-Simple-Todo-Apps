import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/todo_model.dart';

class AddTodoPage extends StatefulWidget {
  final Function(TodoModel) onSave;
  final TodoModel? existingTodo;

  AddTodoPage({required this.onSave, this.existingTodo});

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existingTodo?.title ?? '');
    _descriptionController = TextEditingController(text: widget.existingTodo?.description ?? '');
    _selectedDate = widget.existingTodo?.date ?? DateTime.now();
  }

  void _saveTodo() {
    if (_titleController.text.isNotEmpty) {
      final newTodo = TodoModel(
        id: widget.existingTodo?.id ?? DateTime.now().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        date: _selectedDate,
      );
      widget.onSave(newTodo);
      Navigator.pop(context);
    }
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingTodo == null ? 'Add New Todo' : 'Edit Todo'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveTodo,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Date: ${DateFormat('d MMMM yyyy').format(_selectedDate)}',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                TextButton(
                  onPressed: _pickDate,
                  child: Text('Select Date'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 