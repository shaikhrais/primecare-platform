import 'package:flutter/material.dart';

class ArchitecturePlanningDashboardQuickActionsSection extends StatelessWidget {
  const ArchitecturePlanningDashboardQuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Architect Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Semantics(
                label: 'architectureplanningdashboard_btn_1',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add Blueprint'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'architectureplanningdashboard_btn_2',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Audit DB Schema'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'architectureplanningdashboard_btn_3',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sync Roadmaps'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
