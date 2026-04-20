import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class Cases extends ConsumerWidget {
  const Cases({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'Cases',
      subtitle: 'Auto-scaffolded module',
      kpiCards: [SizedBox.shrink()],
      child: Center(child: Text('Provisioning...')),
    );
  }
}
