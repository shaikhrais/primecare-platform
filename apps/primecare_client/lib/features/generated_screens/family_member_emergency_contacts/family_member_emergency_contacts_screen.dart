// Governance - Category: view | Purpose: Coordinator layout for Family Member Emergency Contacts
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMemberEmergencyContactsScreen extends ConsumerWidget {
  const FamilyMemberEmergencyContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Family Member Emergency Contacts Coordinator'),
      ),
    );
  }
}
