import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ComplianceManagerIncidentReviewScreen extends ConsumerWidget {
  const ComplianceManagerIncidentReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Compliance Manager Incident Review',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: complianceManagerDashboardDataProvider('compliance_manager_incident_review'),
      );
}
