// Governance - Category: view | Purpose: Coordinator layout for Asynchronous Consultation Inbox
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsynchronousConsultationInboxScreen extends ConsumerWidget {
  const AsynchronousConsultationInboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Asynchronous Consultation Inbox Coordinator'),
      ),
    );
  }
}
