// Governance - Category: view | Purpose: Coordinator layout for Psw Check In
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswCheckInScreen extends ConsumerWidget {
  const PswCheckInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Psw Check In Coordinator'),
      ),
    );
  }
}
