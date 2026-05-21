import 'package:flutter/material.dart';

class PswShiftTrackerScreen extends StatelessWidget {
  const PswShiftTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.access_time, size: 32, color: Colors.teal),
                const SizedBox(width: 12),
                Text('Shift Tracker', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal)),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text('Shift Tracker module is natively active.', style: const TextStyle(fontSize: 18, color: Colors.black54)),
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