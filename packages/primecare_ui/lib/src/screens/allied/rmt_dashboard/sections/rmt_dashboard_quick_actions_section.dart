import 'package:flutter/material.dart';

class RmtDashboardQuickActionsSection extends StatelessWidget {
  const RmtDashboardQuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Therapist Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Semantics(
                label: 'rmtdashboard_btn_1',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add SOAP Log'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'rmtdashboard_btn_2',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Start Session'),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                label: 'rmtdashboard_btn_3',
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sync Calendar'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
