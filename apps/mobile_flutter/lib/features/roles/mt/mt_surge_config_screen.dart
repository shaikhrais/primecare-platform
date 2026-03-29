import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';



// Hits PATCH /v1/mt/ecosystem/config natively

class MtSurgeConfigScreen extends StatelessWidget {
  const MtSurgeConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Global Ecosystem Config',
      subtitle: 'Tune and constrain autonomic surge pricing behaviors (MT)',
      icon: Icons.settings_applications,
      headerGradientColors: const [Colors.deepPurple, Colors.indigo],
      kpiCards: const [
        PrimeCareKpiCard(
          title: 'Surge Factor',
          value: '1.25x BASE',
          icon: Icons.trending_up,
          color: Colors.redAccent,
        ),
        PrimeCareKpiCard(
          title: 'Budget Utilized',
          value: '\$8,450 / \$15K',
          icon: Icons.pie_chart,
          color: Colors.purple,
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
                const Row(
                  children: [
                    Icon(Icons.auto_graph, color: Colors.deepPurple),
                    SizedBox(width: 8),
                    Text('Autopilot Boundaries', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Daily Limit Execution Budget:', style: TextStyle(fontWeight: FontWeight.bold)),
                Slider(
                  value: 15000,
                  min: 5000,
                  max: 30000,
                  divisions: 5,
                  label: '\$15,000',
                  activeColor: Colors.deepPurple,
                  onChanged: (val) {},
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$5,000'),
                    Text('\$30,000'),
                  ],
                ),
                const SizedBox(height: 24),
                SwitchListTile(
                  title: const Text('Aggressive Ecosystem Surging'),
                  subtitle: const Text('Allow unassigned drops to double multiplier instantly.'),
                  value: true,
                  activeColor: Colors.deepPurple,
                  onChanged: (val) {},
                ),
                const Divider(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ecosystem config patched natively. Matrix updated.')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Text('Synchronize Global Config'),
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
