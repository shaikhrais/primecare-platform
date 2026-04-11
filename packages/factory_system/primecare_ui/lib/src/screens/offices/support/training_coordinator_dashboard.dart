import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TrainingCoordinatorDashboard extends ConsumerWidget {
  const TrainingCoordinatorDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'support.trainingCoordinator.dashboard.title',
        subtitle: 'support.trainingCoordinator.dashboard.subtitle',
        provider: trainingCoordinatorDashboardDataProvider('training_coordinator'),
      );
}
