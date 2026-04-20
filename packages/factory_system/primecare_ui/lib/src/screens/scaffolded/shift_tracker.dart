import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ShiftTracker extends ConsumerWidget {
  const ShiftTracker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'ShiftTracker',
      subtitle: 'Auto-scaffolded module',
      kpiCards: [SizedBox.shrink()],
      child: Center(child: Text('Provisioning...')),
    );
  }
}
