import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

import 'package:primecare_adapters/primecare_adapters.dart';

class COODashboard extends ConsumerWidget {
  const COODashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate.orchestrate<Result<CooDashboardViewModel>>(
      title: 'COO Dashboard',
      subtitle: 'Logistics and operational execution overview',
      provider: cooDashboardAdapterProvider,
    );
  }
}
