import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class BusinessOverview extends ConsumerWidget {
  const BusinessOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'BusinessOverview',
      subtitle: 'Auto-scaffolded module',
      kpiCards: [SizedBox.shrink()],
      child: Center(child: Text('Provisioning...')),
    );
  }
}
