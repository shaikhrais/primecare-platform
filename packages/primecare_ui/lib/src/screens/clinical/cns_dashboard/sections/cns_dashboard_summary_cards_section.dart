import 'package:flutter/material.dart';

class CnsDashboardSummaryCardsSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const CnsDashboardSummaryCardsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'cnsdashboard_content',
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
                      const Text('Active Consults'),
                      const SizedBox(height: 8),
                      Text('${data['active_consults'] ?? 0}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                      const Text('Pending Approvals'),
                      const SizedBox(height: 8),
                      Text('${data['pending_approvals'] ?? 0}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
