// Governance - Category: view | Purpose: Coordinator layout for Compliance Manager Document Expiry
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceManagerDocumentExpiryScreen extends ConsumerWidget {
  const ComplianceManagerDocumentExpiryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Compliance Manager Document Expiry Coordinator'),
      ),
    );
  }
}
