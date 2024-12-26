import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/services/habit.dart'; 

class ResultScreen extends StatelessWidget {
  final List<Habit> habits;


  ResultScreen({required this.habits});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Summary of Habit Tracking',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: true),
                    bottomTitles: SideTitles(showTitles: true),
                  ),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 10,
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: [
                        FlSpot(0, 3),
                        FlSpot(1, 7),
                        FlSpot(2, 8),
                        FlSpot(3, 5),
                        FlSpot(4, 9),
                        FlSpot(5, 6),
                        FlSpot(6, 8),
                      ],
                      belowBarData: BarAreaData(
                        show: true,
                        colors: [Colors.lightGreen.withOpacity(0.3)],
                      ),
                      colors: [Colors.lightGreen],
                      dotData: FlDotData(show: false),
                      barWidth: 4,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Completion Rate',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                  sections: habits.map((habit) {
                    double progress = habit.getProgress() * 100; 
                    return PieChartSectionData(
                      color: Colors.lightGreen,
                      value: progress,
                      title: '${progress.toStringAsFixed(0)}%',
                      radius: 60,
                      titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Habit Progress Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  Habit habit = habits[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(habit.name),
                      subtitle: Text('Progress: ${habit.getProgress() * 100}%'),
                      trailing: Text('Duration: ${habit.getDuration()}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
