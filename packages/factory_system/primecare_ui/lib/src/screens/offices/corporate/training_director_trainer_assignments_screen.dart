import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TrainingDirectorTrainerAssignmentsScreen extends ConsumerWidget {
  const TrainingDirectorTrainerAssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Training Director Trainer Assignments',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: trainingDirectorDashboardDataProvider('training_director_trainer_assignments'),
      );
}
