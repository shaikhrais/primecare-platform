import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ComplianceManagerComplianceCasesScreen extends ConsumerWidget {
  const ComplianceManagerComplianceCasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Compliance Manager Compliance Cases',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: complianceManagerDashboardDataProvider('compliance_manager_compliance_cases'),
      );
}
