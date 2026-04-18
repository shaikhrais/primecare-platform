import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ComplianceHub extends ConsumerWidget {
  const ComplianceHub({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplate(
      title: 'Compliance Hub',
      subtitle: 'Regulatory and standard compliance status',
      kpiCards: [SizedBox.shrink()],
      child: Center(child: Text('Compliance Interface Provisioning...')),
    );
  }
}
