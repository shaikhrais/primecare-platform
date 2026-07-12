import 'package:flutter/material.dart';

class HswDashboardSummaryCardsSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const HswDashboardSummaryCardsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'hswdashboard_content',
      container: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text('Scheduled Visits'),
                      const SizedBox(height: 8),
                      Text('${data['active_visits'] ?? 0}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text('Completed Visit Logs'),
                      const SizedBox(height: 8),
                      Text('${data['completed_logs'] ?? 0}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
