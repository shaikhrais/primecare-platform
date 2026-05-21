import 'package:flutter/material.dart';

class FamilyLovedOneScheduleScreen extends StatelessWidget {
  const FamilyLovedOneScheduleScreen({Key? key}) : super(key: key);

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
                const Icon(Icons.schedule, size: 40, color: Colors.purple),
                const SizedBox(width: 16),
                Text("Loved One's Schedule", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.purple)),
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
                      const Icon(Icons.schedule, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("Loved One's Schedule is active.", style: const TextStyle(fontSize: 20, color: Colors.black54)),
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