import 'package:flutter/material.dart';

class HswDashboardQuickActionsSection extends StatelessWidget {
  const HswDashboardQuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('HSW Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Semantics(
                label: 'hswdashboard_btn_1',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Log Visit'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'hswdashboard_btn_2',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Safety Check'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'hswdashboard_btn_3',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sync Care Plan'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
