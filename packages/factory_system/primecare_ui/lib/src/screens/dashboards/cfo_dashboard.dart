import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

import 'package:primecare_adapters/primecare_adapters.dart';

class CFODashboard extends ConsumerWidget {
  const CFODashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate.orchestrate<Result<CfoDashboardViewModel>>(
      title: 'CFO Dashboard',
      subtitle: 'Financial statements and forecasts overview',
      provider: cfoDashboardAdapterProvider,
    );
  }
}
