import 'package:flutter/material.dart';
import '../shared/widgets/page_template.dart';
import '../shared/widgets/kpi_card.dart';
// Note: Normally hits /v1/psw/timesheets
// For structural demo, uses static UX composition

class PswTimesheetScreen extends StatelessWidget {
  const PswTimesheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Submit Weekly Timesheet',
      subtitle: 'Compile your field visits into a payable batch',
      icon: Icons.schedule_send,
      headerGradientColors: const [Colors.teal, Colors.tealAccent],
      kpiCards: const [
        UnifiedKpiCard(
          title: 'Unsubmitted Hours',
          value: '38.5 hrs',
          icon: Icons.timer,
          color: Colors.orange,
        ),
        UnifiedKpiCard(
          title: 'Expected Gross',
          value: '\$962.50',
          icon: Icons.monetization_on,
          color: Colors.green,
        ),
      ],
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Current Pay Period', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('March 24th - March 30th, 2026', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 16),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: const Text('Visit - Patient A (AM)'),
                  trailing: const Text('2.5 hrs'),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: const Text('Visit - Patient B (PM)'),
                  trailing: const Text('4.0 hrs'),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Timesheet Status: Submitted successfully!')),
                      );
                    },
                    icon: const Icon(Icons.cloud_upload),
                    label: const Text('Submit to Manager'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.teal,
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
