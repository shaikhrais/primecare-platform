import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:easy_localization/easy_localization.dart';

class ComplianceManagerDashboardScreen extends ConsumerWidget {
  const ComplianceManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Compliance Manager Dashboard',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: complianceManagerDashboardDataProvider('compliance_manager_dashboard'),
      );
}
