import 'package:flutter/material.dart';
import '../shared/widgets/page_template.dart';
import '../shared/widgets/kpi_card.dart';

// Hits PATCH /v1/coordinator/visits/:id natively

class CoordinatorVisitAdjustmentScreen extends StatelessWidget {
  const CoordinatorVisitAdjustmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Schedule Adjustments',
      subtitle: 'Mutate live visit windows securely and trigger waitlist drops',
      icon: Icons.edit_calendar,
      headerGradientColors: const [Colors.amber, Colors.orangeAccent],
      kpiCards: const [
        UnifiedKpiCard(
          title: 'Reschedules (24h)',
          value: '8 Shifts',
          icon: Icons.history,
          color: Colors.orange,
        ),
        UnifiedKpiCard(
          title: 'Waitlist Fill Rate',
          value: '94%',
          icon: Icons.group_add,
          color: Colors.green,
        ),
      ],
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Adjust Visit: VST-9981', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Client: Robert C. • Current: 14:00 - 16:30', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: '15:00',
                        decoration: const InputDecoration(
                          labelText: 'New Start Time',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        initialValue: '120',
                        decoration: const InputDecoration(
                          labelText: 'Duration (mins)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Visit VST-9981 mutated. Ecosystem broadcasted.')),
                      );
                    },
                    icon: const Icon(Icons.published_with_changes),
                    label: const Text('Commit Adjustment'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.amber.shade700,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
