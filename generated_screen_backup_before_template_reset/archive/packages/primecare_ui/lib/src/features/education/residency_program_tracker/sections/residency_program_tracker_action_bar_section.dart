import 'package:flutter/material.dart';

class ResidencyProgramTrackerActionBarSection extends StatelessWidget {
  const ResidencyProgramTrackerActionBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('residency_program_tracker_action_bar-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Action Bar Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
