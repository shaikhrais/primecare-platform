// Governance - Category: view | Purpose: Coordinator layout for Regional Bdm Deal Tracker
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalBdmDealTrackerScreen extends ConsumerWidget {
  const RegionalBdmDealTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Regional Bdm Deal Tracker Coordinator'),
      ),
    );
  }
}
