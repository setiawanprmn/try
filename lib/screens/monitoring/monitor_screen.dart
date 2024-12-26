import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MonitorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Monitor'),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grafik Garis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: true, margin: 8),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        List<String> days = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun'
                        ];
                        if (value.toInt() >= 1 && value.toInt() <= 7) {
                          return days[value.toInt() - 1];
                        }
                        return '';
                      },
                      margin: 8,
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      colors: [Colors.lightGreen],
                      spots: [
                        FlSpot(1, 3),
                        FlSpot(2, 4),
                        FlSpot(3, 2),
                        FlSpot(4, 5),
                        FlSpot(5, 3),
                        FlSpot(6, 4),
                        FlSpot(7, 5),
                      ],
                      belowBarData: BarAreaData(show: true, colors: [
                        Colors.lightGreen.withOpacity(0.2),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Grafik Lingkaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  height: 250,
                  width: 250,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: [
                        PieChartSectionData(
                          value: 40,
                          color: Colors.lightGreen,
                          title: '40%',
                          radius: 50,
                          titleStyle:
                              TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        PieChartSectionData(
                          value: 30,
                          color: Colors.blue,
                          title: '30%',
                          radius: 50,
                          titleStyle:
                              TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        PieChartSectionData(
                          value: 20,
                          color: Colors.orange,
                          title: '20%',
                          radius: 50,
                          titleStyle:
                              TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        PieChartSectionData(
                          value: 10,
                          color: Colors.red,
                          title: '10%',
                          radius: 50,
                          titleStyle:
                              TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          color: Colors.lightGreen,
                        ),
                        SizedBox(width: 8),
                        Text('40%'),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 8),
                        Text('30%'),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 8),
                        Text('20%'),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          color: Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text('10%'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
