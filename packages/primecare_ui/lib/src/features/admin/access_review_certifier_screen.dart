// Governance - Category: view | Purpose: Coordinator layout for Access Review Certifier
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccessReviewCertifierScreen extends ConsumerWidget {
  const AccessReviewCertifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Access Review Certifier Coordinator'),
      ),
    );
  }
}
