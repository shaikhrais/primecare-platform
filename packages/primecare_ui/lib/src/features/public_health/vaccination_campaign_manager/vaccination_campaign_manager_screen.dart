// Governance - Category: view | Purpose: Coordinator layout for Vaccination Campaign Manager
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VaccinationCampaignManagerScreen extends ConsumerWidget {
  const VaccinationCampaignManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Vaccination Campaign Manager Coordinator'),
      ),
    );
  }
}
