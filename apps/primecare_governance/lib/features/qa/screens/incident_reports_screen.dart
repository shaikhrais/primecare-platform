// Governance - Category: view | Purpose: UI Screen component rendering the Incident Reports Screen workspace interface.
import 'package:flutter/material.dart';

class IncidentReportsScreen extends StatelessWidget {
  const IncidentReportsScreen({Key? key}) : super(key: key);

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
                const Icon(Icons.report_problem, size: 40, color: Colors.red),
                const SizedBox(width: 16),
                Text("Incident Reports", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red)),
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
                      const Icon(Icons.report_problem, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("Incident Reports actively running.", style: const TextStyle(fontSize: 20, color: Colors.black54)),
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