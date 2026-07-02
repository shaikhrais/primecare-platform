// Governance - Category: view | Purpose: Coordinator layout for Vendor Risk Assessor
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendorRiskAssessorScreen extends ConsumerWidget {
  const VendorRiskAssessorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Vendor Risk Assessor Coordinator'),
      ),
    );
  }
}
