import 'package:flutter/material.dart';

class Habit {
  String name;
  String description;
  bool isExpanded;
  List<String> tasks;
  List<String> completedTasks;
  DateTime startDate;

  // Konstruktor Habit
  Habit({
    required this.name,
    required this.description,
    this.isExpanded = false,
    this.tasks = const [],
    this.completedTasks = const [],
    required this.startDate,
  });

  double getProgress() {
    int completedTasksCount = completedTasks.length;
    int totalTasksCount = tasks.length;
    return totalTasksCount == 0 ? 0.0 : completedTasksCount / totalTasksCount;
  }


  String getDuration() {
    Duration duration = DateTime.now().difference(startDate);
    int days = duration.inDays;
    return '$days days';
  }
}
