// Governance - Category: view | Purpose: Coordinator layout for Regional Bdm Partners
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalBdmPartnersScreen extends ConsumerWidget {
  const RegionalBdmPartnersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Regional Bdm Partners Coordinator'),
      ),
    );
  }
}
