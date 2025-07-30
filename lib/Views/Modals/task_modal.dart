import 'package:flutter/widgets.dart';

class TaskModel {
  final String title;
  int? index;
  final DateTime date;
  final String priority;
  bool ischecked;

  TaskModel({
    required this.title,
    this.index,
    required this.date,
    this.ischecked = false,
    required this.priority,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': index,
      'date': date.toIso8601String(),
      'priority': priority,
      'ischecked': ischecked,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      index: json['id'],
      priority: json['priority'],
      ischecked: json['ischecked'],
      date: DateTime.parse(json['date']),
    );
  }
}
