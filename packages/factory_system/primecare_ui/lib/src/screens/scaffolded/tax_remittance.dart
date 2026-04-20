import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TaxRemittance extends ConsumerWidget {
  const TaxRemittance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'TaxRemittance',
      subtitle: 'Auto-scaffolded module',
      kpiCards: [SizedBox.shrink()],
      child: Center(child: Text('Provisioning...')),
    );
  }
}
