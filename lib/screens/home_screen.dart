import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> healthyTips = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHealthyTips();
  }

  Future<void> fetchHealthyTips() async {
    try {
      final url = Uri.parse(
          'https://odphp.health.gov/myhealthfinder/api/v3/itemlist.json?Type=topic');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['Result']['Items']['Item'] as List<dynamic>;

        setState(() {
          healthyTips = items
              .map((item) => item['Title'] as String)
              .toList(); // Extracting Titles
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load healthy tips');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    } else if (hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Tracker'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("User Name"),
              accountEmail: Text("user@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black),
              ),
            ),
            ListTile(
              title: Text('Monitoring'),
              onTap: () {
                Navigator.pushNamed(context, '/monitor');
              },
            ),
            ListTile(
              title: Text('Habit List'),
              onTap: () {
                Navigator.pushNamed(context, '/habit-list');
              },
            ),
            ListTile(
              title: Text('Result'),
              onTap: () {
                Navigator.pushNamed(context, '/result');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            color: Colors.lightGreen,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text(
                    'Halo User, ${greeting()}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Selamat datang di Habit Tracker!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 30),
                if (isLoading)
                  CircularProgressIndicator()
                else if (healthyTips.isEmpty)
                  Text(
                    'No healthy tips available.',
                    style: TextStyle(color: Colors.red),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 150.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      items: healthyTips.map((tip) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    tip,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
