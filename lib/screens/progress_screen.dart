import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Text(
          'Progress and Statistics Page',
          style: TextStyle(color: Colors.black), 
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
