import 'package:flutter/material.dart';
import 'package:multi_localization_app/Views/todolist/todo_provider.dart';
import 'package:multi_localization_app/constant/constant_widget.dart';
import 'package:provider/provider.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});
  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _tasks = [];

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['done'] = !_tasks[index]['done'];
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasklist = context.watch<TodoProvider>().tasks;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: CustomWidgets.customTextFieldupdate(
                      context: context,

                      maxLines: 5,
                      controller: _controller,
                      hint: 'Add a new task',
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      width: MediaQuery.of(context).size.width - 100,
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      Consumer<TodoProvider>(
                        builder: (context, todoProvider, child) {
                          return CustomWidgets.customButton(
                            context: context,
                            onPressed: () {
                              if (_controller.text.isNotEmpty) {
                                todoProvider.addTask(_controller.text);
                                _controller.clear();
                              }
                            },
                            buttonName: 'Add',
                            btnColor: Colors.blue,
                            radius: 5,
                            width: 80,
                            height: 40,
                          );
                        },
                      ),
                      Consumer<TodoProvider>(
                        builder: (context, todoProvider, child) {
                          return CustomWidgets.customButton(
                            context: context,
                            onPressed: () {
                              todoProvider.clearTasks();
                            },
                            buttonName: 'Clear',
                            btnColor: Colors.blue,
                            radius: 5,
                            width: 80,
                            height: 40,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: todoProvider.tasks.length,
                    itemBuilder: (context, index) {
                      final task = todoProvider.tasks[index];
                      return Card(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: task.startsWith('✓ '),
                            onChanged: (value) {
                              todoProvider.toggleTask(index);
                            },
                          ),
                          title: Text(task),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => todoProvider.removeTask(index),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
