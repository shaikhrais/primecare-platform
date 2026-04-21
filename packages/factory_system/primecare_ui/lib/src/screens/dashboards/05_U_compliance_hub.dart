// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

class ComplianceHub extends ConsumerWidget {
  const ComplianceHub({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'Compliance Hub',
      subtitle: 'Regulatory and standard compliance status',
      kpis: [],
      body: Center(child: Text('Compliance Interface Provisioning...')),
    );
  }
}
