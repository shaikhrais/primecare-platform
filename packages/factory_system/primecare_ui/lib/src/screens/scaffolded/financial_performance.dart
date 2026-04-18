import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FinancialPerformance extends ConsumerWidget {
  const FinancialPerformance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'FinancialPerformance',
      subtitle: 'Auto-scaffolded module',
      kpiCards: [SizedBox.shrink()],
      child: Center(child: Text('Provisioning...')),
    );
  }
}
