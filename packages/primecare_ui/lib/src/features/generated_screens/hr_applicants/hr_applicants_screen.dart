// Governance - Category: view | Purpose: Coordinator layout for Hr Applicants
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrApplicantsScreen extends ConsumerWidget {
  const HrApplicantsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Hr Applicants Coordinator'),
      ),
    );
  }
}
