import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class IntakeCoordinatorReportsScreen extends ConsumerWidget {
  const IntakeCoordinatorReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Intake Coordinator Reports',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: intakeDashboardDataProvider('intake_coordinator_reports'),
      );
}
