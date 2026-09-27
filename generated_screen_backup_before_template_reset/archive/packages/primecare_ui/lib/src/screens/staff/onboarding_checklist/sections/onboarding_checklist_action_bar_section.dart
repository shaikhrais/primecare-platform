import 'package:flutter/material.dart';

class OnboardingChecklistActionBarSection extends StatelessWidget {
  const OnboardingChecklistActionBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('onboarding_checklist_action_bar-section'),
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
