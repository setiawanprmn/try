import 'package:flutter/material.dart';

class HabitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit List'),
        backgroundColor: Colors.lightGreen, 
      ),
      body: Center(
        child: Text(
          'List of Habits',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.grey[200], 
    );
  }
}
