// Governance - Category: view | Purpose: Coordinator layout for Mobile Clinic Dispatch
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileClinicDispatchScreen extends ConsumerWidget {
  const MobileClinicDispatchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Mobile Clinic Dispatch Coordinator'),
      ),
    );
  }
}
