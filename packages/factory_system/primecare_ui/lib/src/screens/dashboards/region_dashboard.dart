import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

import 'package:primecare_adapters/primecare_adapters.dart';

class RegionDashboard extends ConsumerWidget {
  const RegionDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate.orchestrate<
      Result<RegionalManagerOntarioDashboardViewModel>
    >(
      title: 'Regional Dashboard',
      subtitle: 'Regional performance overview',
      provider: regionalManagerOntarioDashboardAdapterProvider,
    );
  }
}
