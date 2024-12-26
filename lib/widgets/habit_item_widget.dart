import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitItemWidget extends StatelessWidget {
  final Habit habit;

  HabitItemWidget({required this.habit});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(habit.name),
        trailing: IconButton(
          icon: Icon(Icons.check_circle_outline),
          onPressed: () {
          },
        ),
      ),
    );
  }
}
