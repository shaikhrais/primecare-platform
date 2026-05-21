import 'package:flutter/material.dart';

class TrainingDirectorTrainerAssignmentsScreen extends StatelessWidget {
  const TrainingDirectorTrainerAssignmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person_pin, size: 40, color: Colors.orange.shade800),
                const SizedBox(width: 16),
                Text("Trainer Assignments", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange.shade800)),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_pin, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("Trainer Assignments actively running.", style: TextStyle(fontSize: 20, color: Colors.black54)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
