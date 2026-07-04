import 'package:flutter/material.dart';

class CooSchedulingHealthPrimaryContentSection extends StatelessWidget {
  const CooSchedulingHealthPrimaryContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('coo_scheduling_health_primary_content-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Primary Content Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
