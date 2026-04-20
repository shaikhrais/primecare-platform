import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

import 'package:primecare_adapters/primecare_adapters.dart';

class CeoDashboard extends ConsumerWidget {
  const CeoDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate.orchestrate<Result<CeoDashboardViewModel>>(
      title: 'CEO Dashboard',
      subtitle: 'Executive overview and corporate strategy',
      provider: ceoDashboardAdapterProvider,
    );
  }
}
