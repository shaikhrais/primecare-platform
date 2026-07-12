import 'package:flutter/material.dart';

class RmtDashboardSummaryCardsSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const RmtDashboardSummaryCardsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'primary_content',
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
                      const Text('Active SOAP Patients'),
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
                      const Text('Pending Notes'),
                      const SizedBox(height: 8),
                      Text('${data['pending_notes'] ?? 0}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
