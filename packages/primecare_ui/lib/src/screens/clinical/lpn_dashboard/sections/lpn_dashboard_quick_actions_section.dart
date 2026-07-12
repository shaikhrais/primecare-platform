import 'package:flutter/material.dart';

class LpnDashboardQuickActionsSection extends StatelessWidget {
  const LpnDashboardQuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LPN Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Semantics(
                label: 'lpndashboard_btn_1',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Record Med'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'lpndashboard_btn_2',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Log Vitals'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'lpndashboard_btn_3',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sync Medication Sheet'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
