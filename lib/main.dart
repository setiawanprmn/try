import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/monitoring/monitor_screen.dart';
import 'screens/monitoring/habit_list_screen.dart';
import 'screens/monitoring/result_screen.dart';
import 'services/habit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      initialRoute: '/home',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/monitor': (context) => MonitorScreen(),
        '/habit-list': (context) => HabitsListScreen(),
        '/result': (context) => ResultScreen(habits: []),
      },
    );
  }
}
