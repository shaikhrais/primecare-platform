import 'package:flutter/material.dart';

class HrHiringOnboardingContentSummarySection extends StatelessWidget {
  final Map<String, dynamic> data;
  const HrHiringOnboardingContentSummarySection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'hr_hiring_onboarding_content_summary_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Content Summary Section', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Clinical Care Operations Status.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
