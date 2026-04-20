import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RegionPerformance extends ConsumerWidget {
  const RegionPerformance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'RegionPerformance',
      subtitle: 'Auto-scaffolded module',
      kpiCards: [SizedBox.shrink()],
      child: Center(child: Text('Provisioning...')),
    );
  }
}
