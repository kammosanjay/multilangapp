import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  List<String> _tasks = [];
  List<String> get tasks => _tasks;

  void addTask(String task) {
    if (task.isNotEmpty) {
      _tasks.add(task);
      notifyListeners();
    }
  }

  void removeTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
      notifyListeners();
    }
  }

  void clearTasks() {
    _tasks.clear();
    notifyListeners();
  }

  void toggleTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index] = _tasks[index].startsWith('✓ ')
          ? _tasks[index].substring(2)
          : '✓ ${_tasks[index]}';
      notifyListeners();
    }
  }
}
