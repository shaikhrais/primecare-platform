// Governance - Category: view | Purpose: Coordinator layout for Psw Patient Profile
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswPatientProfileScreen extends ConsumerWidget {
  const PswPatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Psw Patient Profile Coordinator'),
      ),
    );
  }
}
