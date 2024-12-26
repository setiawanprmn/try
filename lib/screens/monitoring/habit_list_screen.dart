import 'package:flutter/material.dart';

class HabitsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Scaffold(
          body: HabitsScreen(),
        );
      },
    );
  }
}

class HabitsScreen extends StatefulWidget {
  @override
  _HabitsScreenState createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  List<Habit> habits = [];

  TextEditingController habitNameController = TextEditingController();
  TextEditingController habitDescriptionController = TextEditingController();

  void addHabit() {
    if (habitNameController.text.isNotEmpty &&
        habitDescriptionController.text.isNotEmpty) {
      setState(() {
        habits.add(Habit(
          name: habitNameController.text,
          description: habitDescriptionController.text,
          isExpanded: false,
          tasks: [],
          completedTasks: [],
        ));
        habitNameController.clear();
        habitDescriptionController.clear();
      });
    }
  }

  void toggleExpansion(int index) {
    setState(() {
      habits[index].isExpanded = !habits[index].isExpanded;
    });
  }

  void openManageDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Manage Kebiasaan'),
          content: Container(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Kebiasaan: ${habits[index].name}'),
                SizedBox(height: 10),
                TextField(
                  controller: TextEditingController(text: habits[index].name),
                  decoration: InputDecoration(
                    labelText: 'Nama Kebiasaan',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                  onChanged: (value) {
                    setState(() {
                      habits[index].name = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller:
                      TextEditingController(text: habits[index].description),
                  decoration: InputDecoration(
                    labelText: 'Deskripsi Kebiasaan',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                  onChanged: (value) {
                    setState(() {
                      habits[index].description = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                Text('Tugas Kebiasaan:'),
                ...habits[index].tasks.map((task) {
                  return CheckboxListTile(
                    title: Text(task),
                    value: habits[index].completedTasks.contains(task),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          habits[index].completedTasks.add(task);
                        } else {
                          habits[index].completedTasks.remove(task);
                        }
                      });
                    },
                  );
                }).toList(),
                SizedBox(height: 10),
                TextField(
                  onSubmitted: (value) {
                    setState(() {
                      habits[index].tasks.add(value);
                    });
                  },
                  controller: habitDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Tambahkan tugas',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          if (habitDescriptionController.text.isNotEmpty) {
                            habits[index]
                                .tasks
                                .add(habitDescriptionController.text);
                            habitDescriptionController.clear();
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tutup'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void deleteHabit(int index) {
    setState(() {
      habits.removeAt(index);
    });
  }

  void confirmDeleteHabit(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Apakah kamu yakin?'),
          content: Text(
              'Semua progressmu akan hilang jika kamu menghapus kebiasaan ini.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tidak'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteHabit(index);
                Navigator.pop(context);
              },
              child: Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  double getProgress(int index) {
    int completedTasks = habits[index].completedTasks.length;
    int totalTasks = habits[index].tasks.length;
    return totalTasks == 0 ? 0.0 : completedTasks / totalTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit List'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  return HabitTile(
                    habit: habits[index],
                    onTap: () => toggleExpansion(index),
                    onManage: () => openManageDialog(index),
                    onDelete: () => confirmDeleteHabit(index),
                    progress: getProgress(index),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Tambah Kebiasaan'),
                      content: Container(
                        width: 500,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: habitNameController,
                              decoration: InputDecoration(
                                labelText: 'Nama Kebiasaan',
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: habitDescriptionController,
                              decoration: InputDecoration(
                                labelText: 'Deskripsi Kebiasaan',
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Tutup'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            addHabit();
                            Navigator.pop(context);
                          },
                          child: Text('Tambah'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Tambah Kebiasaan'),
            ),
          ],
        ),
      ),
    );
  }
}

class Habit {
  String name;
  String description;
  bool isExpanded;
  List<String> tasks;
  List<String> completedTasks;

  Habit({
    required this.name,
    required this.description,
    this.isExpanded = false,
    this.tasks = const [],
    this.completedTasks = const [],
  });
}

class HabitTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback onTap;
  final VoidCallback onManage;
  final VoidCallback onDelete;
  final double progress;

  const HabitTile({
    Key? key,
    required this.habit,
    required this.onTap,
    required this.onManage,
    required this.onDelete,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text(habit.name),
          ],
        ),
        subtitle: Text(habit.description),
        trailing: Icon(
          habit.isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          color: Colors.green,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  title: Text('Manage Kebiasaan'),
                  onTap: onManage,
                ),
                ListTile(
                  title: Text('Hapus Kebiasaan'),
                  onTap: onDelete,
                ),
                SizedBox(height: 10),
                progress < 1.0
                    ? Text('Progres: ${(progress * 100).toStringAsFixed(0)}%')
                    : Text('Kebiasaan Selesai'),
              ],
            ),
          ),
        ],
        onExpansionChanged: (bool expanded) {
          onTap();
        },
      ),
    );
  }
}
