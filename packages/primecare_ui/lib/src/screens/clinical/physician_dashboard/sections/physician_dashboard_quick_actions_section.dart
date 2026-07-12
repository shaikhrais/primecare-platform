import 'package:flutter/material.dart';

class PhysicianDashboardQuickActionsSection extends StatelessWidget {
  const PhysicianDashboardQuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Physician Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Semantics(
                label: 'physiciandashboard_btn_1',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Admit Patient'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'physiciandashboard_btn_2',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Request Labs'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'physiciandashboard_btn_3',
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
