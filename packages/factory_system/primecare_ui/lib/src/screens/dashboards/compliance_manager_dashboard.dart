import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

class ComplianceManagerDashboard extends ConsumerWidget {
  const ComplianceManagerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate.orchestrate<
      Result<ComplianceManagerDashboardViewModel>
    >(
      title: 'Compliance Dashboard',
      subtitle: 'Regulatory compliance and audit overview',
      provider: complianceManagerDashboardAdapterProvider,
    );
  }
}
