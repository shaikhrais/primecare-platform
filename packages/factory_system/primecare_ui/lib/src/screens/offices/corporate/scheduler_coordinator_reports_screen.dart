import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class SchedulerCoordinatorReportsScreen extends ConsumerWidget {
  const SchedulerCoordinatorReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Scheduler Coordinator Reports',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: schedulerDashboardDataProvider('scheduler_coordinator_reports'),
      );
}
