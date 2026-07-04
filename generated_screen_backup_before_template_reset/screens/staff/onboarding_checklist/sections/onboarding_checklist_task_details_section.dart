import 'package:flutter/material.dart';

class OnboardingChecklistTaskDetailsSection extends StatelessWidget {
  const OnboardingChecklistTaskDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('onboarding_checklist_task_details-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Task Details Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
