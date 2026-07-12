import 'package:flutter/material.dart';

class LpnDashboardSummaryCardsSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const LpnDashboardSummaryCardsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'lpndashboard_content',
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
                      const Text('Active Patients'),
                      const SizedBox(height: 8),
                      Text('${data['active_patients'] ?? 0}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                      const Text('Completed Treatments'),
                      const SizedBox(height: 8),
                      Text('${data['completed_treatments'] ?? 0}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
