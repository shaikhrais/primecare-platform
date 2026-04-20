import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class BranchComparison extends ConsumerWidget {
  const BranchComparison({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'BranchComparison',
      subtitle: 'Auto-scaffolded module',
      kpiCards: [SizedBox.shrink()],
      child: Center(child: Text('Provisioning...')),
    );
  }
}
