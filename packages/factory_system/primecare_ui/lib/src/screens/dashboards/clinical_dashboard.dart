import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

class ClinicalDashboard extends ConsumerWidget {
  const ClinicalDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate.orchestrate<Result<ClinicDashboardViewModel>>(
      title: 'Clinical Dashboard',
      subtitle: 'Clinical outcomes and patient care overview',
      provider: clinicDashboardAdapterProvider,
    );
  }
}
