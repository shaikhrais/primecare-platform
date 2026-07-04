import 'package:flutter/material.dart';

class RpnCarePlanReviewActionBarSection extends StatelessWidget {
  const RpnCarePlanReviewActionBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('rpn_care_plan_review_action_bar-section'),
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
