import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ComplianceManagerDashboardScreen extends ConsumerWidget {
  const ComplianceManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'common.complianceManager.dashboard.title',
        subtitle: 'common.complianceManager.dashboard.subtitle',
        provider: complianceManagerDashboardDataProvider('compliance_manager'),
      );
}
