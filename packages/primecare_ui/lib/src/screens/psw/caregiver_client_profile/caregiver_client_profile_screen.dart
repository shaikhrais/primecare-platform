// Governance - Category: view | Purpose: Coordinator layout for CaregiverClientProfileScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverClientProfileScreen extends ConsumerWidget {
  const CaregiverClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('CaregiverClientProfileScreen Coordinator'),
      ),
    );
  }
}
