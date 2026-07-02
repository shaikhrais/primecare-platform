// Governance - Category: view | Purpose: Coordinator layout for Adverse Event Reporting Portal
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdverseEventReportingPortalScreen extends ConsumerWidget {
  const AdverseEventReportingPortalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Adverse Event Reporting Portal Coordinator'),
      ),
    );
  }
}
