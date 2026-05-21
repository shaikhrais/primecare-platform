import 'package:flutter/material.dart';

class PswCarePlanScreen extends StatefulWidget {
  const PswCarePlanScreen({Key? key}) : super(key: key);

  @override
  State<PswCarePlanScreen> createState() => _PswCarePlanScreenState();
}

class _PswCarePlanScreenState extends State<PswCarePlanScreen> {
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Assist with Morning Hygiene', 'icon': Icons.water_drop, 'color': Colors.blue, 'done': false},
    {'title': 'Administer Medication (12:00 PM)', 'icon': Icons.medication, 'color': Colors.red, 'done': false},
    {'title': 'Prepare Low Sodium Lunch', 'icon': Icons.restaurant, 'color': Colors.green, 'done': false},
    {'title': 'Physical Therapy Exercises', 'icon': Icons.accessibility_new, 'color': Colors.orange, 'done': false},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Care Plan: John Doe'), backgroundColor: Colors.teal),
        body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            final task = _tasks[index];
            return Card(
              elevation: task['done'] ? 1 : 4,
              color: task['done'] ? Colors.grey.shade100 : Colors.white,
              child: CheckboxListTile(
                secondary: Icon(task['icon'], color: task['done'] ? Colors.grey : task['color'], size: 32),
                title: Text(task['title'], style: TextStyle(
                  fontSize: 18, 
                  decoration: task['done'] ? TextDecoration.lineThrough : null,
                  color: task['done'] ? Colors.grey : Colors.black87
                )),
                value: task['done'],
                activeColor: Colors.teal,
                onChanged: (bool? value) {
                  setState(() {
                    _tasks[index]['done'] = value ?? false;
                  });
                  if (value == true) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Completed: \${task['title']}")));
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}