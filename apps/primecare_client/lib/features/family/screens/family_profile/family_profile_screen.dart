// Governance - Category: view | Purpose: Coordinator layout for Family Profile
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyProfileScreen extends ConsumerWidget {
  const FamilyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Family Profile Coordinator'),
      ),
    );
  }
}
