import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:multi_localization_app/Views/Modals/task_modal.dart';

import 'package:flutter/foundation.dart';

class TodoProvider with ChangeNotifier {
  TodoProvider() {
    loadTasks();
  }

  ///
  ///
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  // ✅ Add a new task
  void addTask(TaskModel task) {
    _tasks.add(task); // add first

    final box = GetStorage();
    final List<Map<String, dynamic>> taskJsonList = _tasks
        .map((task) => task.toJson())
        .toList();

    box.write('tasklist', taskJsonList);
    notifyListeners();
  }

  ///
  ///
  void loadTasks() {
    final box = GetStorage();
    final List<dynamic>? storedTasks = box.read('tasklist');

    if (storedTasks != null && storedTasks.isNotEmpty) {
      _tasks = storedTasks
          .map((taskJson) => TaskModel.fromJson(taskJson))
          .toList();
    } else {
      _tasks = [];
    }

    notifyListeners();
  }

  // ✅ Remove task by index
  void removeTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);

      final box = GetStorage();
      final taskJsonList = _tasks.map((task) => task.toJson()).toList();
      box.write('tasklist', taskJsonList);

      notifyListeners();
    }
  }

  // ✅ Toggle task completion
  void toggleTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index].ischecked = !_tasks[index].ischecked;

      // 🔧 Save to GetStorage
      final box = GetStorage();
      final taskJsonList = _tasks.map((task) => task.toJson()).toList();
      box.write('tasklist', taskJsonList);

      notifyListeners();
    }
  }

  // ✅ Clear all tasks
  void clearTasks() {
    _tasks.clear();

    final box = GetStorage();
    box.remove('tasklist'); // Clear from persistent storage

    notifyListeners();
  }

  // ✅ Update task details (title, date, priority, etc.)
  void updateTask(TaskModel updatedTask) {
    int index = _tasks.indexWhere((task) => task.index == updatedTask.index);
    if (index != -1) {
      _tasks[index] = updatedTask;
      final box = GetStorage();
      box.write('tasklist', _tasks.map((e) => e.toJson()).toList());
      notifyListeners();
    }
  }
}
