import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ComplianceStatus extends ConsumerWidget {
  const ComplianceStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'ComplianceStatus',
      subtitle: 'Auto-scaffolded module',
      kpiCards: [SizedBox.shrink()],
      child: Center(child: Text('Provisioning...')),
    );
  }
}
