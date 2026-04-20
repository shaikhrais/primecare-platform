import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ApiMonitoring extends ConsumerWidget {
  const ApiMonitoring({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'ApiMonitoring',
      subtitle: 'Auto-scaffolded module',
      kpiCards: [SizedBox.shrink()],
      child: Center(child: Text('Provisioning...')),
    );
  }
}
