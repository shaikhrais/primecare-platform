import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class MarketingHub extends ConsumerWidget {
  const MarketingHub({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'MarketingHub',
      subtitle: 'Auto-scaffolded module',
      kpiCards: [SizedBox.shrink()],
      child: Center(child: Text('Provisioning...')),
    );
  }
}
