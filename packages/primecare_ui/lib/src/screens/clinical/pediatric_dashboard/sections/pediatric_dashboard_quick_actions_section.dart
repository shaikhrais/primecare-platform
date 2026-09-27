import 'package:flutter/material.dart';

class PediatricDashboardQuickActionsSection extends StatelessWidget {
  const PediatricDashboardQuickActionsSection({super.key});

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
                label: 'pediatricdashboard_btn_1',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Log Growth'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'pediatricdashboard_btn_2',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Log Vaccine'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'pediatricdashboard_btn_3',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sync Cases'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
