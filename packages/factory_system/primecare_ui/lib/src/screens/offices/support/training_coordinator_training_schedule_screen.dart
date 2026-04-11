import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart' hide trainingCoordinatorDashboardAdapterProvider;
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TrainingCoordinatorTrainingScheduleScreen extends ConsumerWidget {
  const TrainingCoordinatorTrainingScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'TrainingCoordinatorTrainingScheduleScreen',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: trainingCoordinatorDashboardAdapterProvider,
      );
}
