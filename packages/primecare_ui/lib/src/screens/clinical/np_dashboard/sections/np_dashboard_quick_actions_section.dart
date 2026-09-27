import 'package:flutter/material.dart';

class NpDashboardQuickActionsSection extends StatelessWidget {
  const NpDashboardQuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Clinical Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Semantics(
                label: 'npdashboard_btn_1',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add Patient Log'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'npdashboard_btn_2',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Order Rx'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'npdashboard_btn_3',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Request Triage'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
