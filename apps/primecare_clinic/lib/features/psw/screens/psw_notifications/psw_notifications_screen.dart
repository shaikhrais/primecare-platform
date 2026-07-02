// Governance - Category: view | Purpose: Coordinator layout for Psw Notifications
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswNotificationsScreen extends ConsumerWidget {
  const PswNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Psw Notifications Coordinator'),
      ),
    );
  }
}
