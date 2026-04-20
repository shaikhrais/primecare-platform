import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class Referrals extends ConsumerWidget {
  const Referrals({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'Referrals',
      subtitle: 'Auto-scaffolded module',
      kpiCards: [SizedBox.shrink()],
      child: Center(child: Text('Provisioning...')),
    );
  }
}
