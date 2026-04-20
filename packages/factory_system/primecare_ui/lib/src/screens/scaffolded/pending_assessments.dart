import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PendingAssessments extends ConsumerWidget {
  const PendingAssessments({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'PendingAssessments',
      subtitle: 'Auto-scaffolded module',
      kpiCards: [SizedBox.shrink()],
      child: Center(child: Text('Provisioning...')),
    );
  }
}
