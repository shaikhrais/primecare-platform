// Governance - Category: view | Purpose: UI Screen component rendering the Hr Hiring Reports Screen workspace interface.
import 'package:flutter/material.dart';

class HrHiringReportsScreen extends StatelessWidget {
  const HrHiringReportsScreen({Key? key}) : super(key: key);

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
                Icon(Icons.bar_chart, size: 40, color: Colors.purple.shade500),
                const SizedBox(width: 16),
                Text("Reports", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.purple.shade500)),
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
                      Icon(Icons.bar_chart, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("Reports actively running.", style: TextStyle(fontSize: 20, color: Colors.black54)),
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
