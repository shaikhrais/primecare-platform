import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

import 'package:primecare_adapters/primecare_adapters.dart';

class SystemDashboard extends ConsumerWidget {
  const SystemDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate.orchestrate<Result<GeneralManagerDashboardViewModel>>(
      title: 'System Dashboard',
      subtitle: 'Enterprise-wide operational overview',
      provider: generalManagerDashboardAdapterProvider,
    );
  }
}
