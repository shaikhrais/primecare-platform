import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

class CTODashboard extends ConsumerWidget {
  const CTODashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate.orchestrate<Result<CtoDashboardViewModel>>(
      title: 'CTO Dashboard',
      subtitle: 'Technical operations overview',
      provider: ctoDashboardAdapterProvider,
    );
  }
}
