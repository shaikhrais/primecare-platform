import 'package:flutter/material.dart';

class CnsDashboardQuickActionsSection extends StatelessWidget {
  const CnsDashboardQuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CNS Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Semantics(
                label: 'cnsdashboard_btn_1',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add Protocol'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'cnsdashboard_btn_2',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Audit Practice'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'cnsdashboard_btn_3',
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
