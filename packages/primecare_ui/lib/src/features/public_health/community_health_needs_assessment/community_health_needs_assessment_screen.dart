// Governance - Category: view | Purpose: Coordinator layout for Community Health Needs Assessment
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityHealthNeedsAssessmentScreen extends ConsumerWidget {
  const CommunityHealthNeedsAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Community Health Needs Assessment Coordinator'),
      ),
    );
  }
}
